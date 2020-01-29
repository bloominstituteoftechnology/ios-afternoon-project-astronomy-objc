//
//  JBPhotoController.m
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-27.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import "JBPhotoController.h"
#import "JBNetworkManager.h"
#import "JBSol.h"
#import "JBPhotoReference.h"
#import "NSURL+JBUsingHTTPS.h"
#import "JBCache.h"
#import "JBFetchOperation.h"


static NSString * baseURLString = @"https://api.nasa.gov/mars-photos/api/v1";
static NSString * kAPIKey = @"IK5EXzl5H70cLbyq5Jyp4bM8eN9icJNHzpBygHiF";


@interface JBPhotoController ()

@property (nonatomic, nonnull) JBNetworkManager *networkManager;
@property (nonatomic, nonnull) NSMutableArray<JBSol *> *mutableSols;
@property (atomic, nonnull) NSCache *imageCache;
@property (atomic, nonnull) NSCache *photoRefsCache;
@property (nonatomic, nonnull) NSOperationQueue *fetchQueue;
@property (nonatomic, nonnull) NSMutableDictionary *fetchOperations;

- (NSMutableArray<JBSol *> *)decodeSolsFromDictionary:(NSDictionary *)dictionary;

@end


@implementation JBPhotoController

#pragma mark - Setup

- (instancetype)init
{
    self = [super init];
    if (self) {
        _mutableSols = [@[] mutableCopy];
        _networkManager = [[JBNetworkManager alloc] init];
        _networkManager.acceptNilData = NO;
        _imageCache = [[NSCache alloc] init];
        _imageCache.totalCostLimit = 104857600;
        _imageCache.delegate = self;
        _photoRefsCache = [[NSCache alloc] init];
        _photoRefsCache.delegate = self;
        _fetchQueue = [[NSOperationQueue alloc] init];
        _fetchOperations = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (NSArray<JBSol *> *)sols
{
    return [self.mutableSols copy];
}

# pragma mark - Regular Fetches

- (void)fetchMissionManifestWithCompletion:(void (^)(NSError * _Nullable))completion {
    NSURL *originalURL = [[NSURL URLWithString:baseURLString]
                          URLByAppendingPathComponent:@"manifests/curiosity"];
    NSURLComponents *components = [NSURLComponents componentsWithURL:originalURL
                                             resolvingAgainstBaseURL:NO];
    components.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"api_key" value:kAPIKey]
    ];

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:components.URL];
    [[self.networkManager fetchDictionaryWithRequest:request
                                          completion:^(NSDictionary * _Nullable dictionary,
                                                       NSError * _Nullable error)
    {
        if (error) {
            completion(error);
            return;
        }
        if (dictionary == nil) {
            NSLog(@"Error: manifest dictionary is nil");
            completion([NSError errorWithDomain:NSURLErrorDomain code:-1 userInfo:nil]);
            return;
        }

        self.mutableSols = [self decodeSolsFromDictionary:dictionary];
        completion(nil);
    }] resume];
}

- (void)fetchPhotoReferencesForSol:(JBSol *)sol
                        completion:(void (^)(NSArray<JBPhotoReference *> *,
                                             NSError *))completion
{
    // if we're fetching new photo references, then we're changing sols, so we should cancel any fetch ops from the last sol
    for (NSOperation *fetchOp in self.fetchOperations.allValues) {
        [fetchOp cancel];
    }
    NSArray<JBPhotoReference *> *photoRefs = [self.photoRefsCache objectForKey:sol];
    if (photoRefs) {
        completion(photoRefs, nil);
        return;
    }
    NSURL *originalURL = [[NSURL URLWithString:baseURLString]
                  URLByAppendingPathComponent:@"rovers/curiosity/photos"];
    NSURLComponents *components = [NSURLComponents componentsWithURL:originalURL
                                             resolvingAgainstBaseURL:NO];
    components.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"api_key" value:kAPIKey],
        [NSURLQueryItem queryItemWithName:@"sol"
                                    value:[NSString stringWithFormat:@"%lu",
                                           sol.marsSol]]
    ];

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:components.URL];
    [[self.networkManager fetchDictionaryWithRequest:request
                                          completion:^(NSDictionary * _Nullable dictionary,
                                                       NSError * _Nullable error)
    {
        if (error) {
            completion(nil, error);
            return;
        }
        if (dictionary == nil) {
            NSLog(@"Error: sol photo reference dictionary is nil");
            completion(nil, [NSError errorWithDomain:NSURLErrorDomain code:-1 userInfo:nil]);
            return;
        }

        NSArray *photoRefDicts = dictionary[@"photos"];
        NSMutableArray *mutablePhotoRefs = [@[] mutableCopy];
        for (NSDictionary *photoRefDict in photoRefDicts) {
            JBPhotoReference *photoRef = [[JBPhotoReference alloc]
                                          initFromDictionary:photoRefDict];
            [mutablePhotoRefs addObject:photoRef];
        }

        NSArray<JBPhotoReference *> *newPhotoRefs = [mutablePhotoRefs copy];
        completion([mutablePhotoRefs copy], nil);
        [self.photoRefsCache setObject:newPhotoRefs forKey:sol];
    }] resume];
}

#pragma mark - Operations

- (void)fetchPhotoForReference:(JBPhotoReference *)photoRef
                    completion:(void (^)(UIImage *,
                                         NSError *))completion
{
    NSNumber *photoIDNumber = [NSNumber numberWithUnsignedInteger:photoRef.photoID];
    UIImage *image = [self.imageCache objectForKey:photoIDNumber];
    if (image) {
        completion(image, nil);
        return;
    }

    NSURLRequest *request = [[NSURLRequest alloc]
                             initWithURL:photoRef.imageURL.urlUsingHTTPS];
    JBFetchOperation *fetchOp = [[JBFetchOperation alloc] initWithRequest:request];
    NSBlockOperation *cacheOp = [NSBlockOperation blockOperationWithBlock:^{
        if (fetchOp.image) {
            [self.imageCache setObject:fetchOp.image
                                forKey:photoIDNumber
                                  cost:fetchOp.data.length];
        } else if (!fetchOp.isCancelled) {
            NSLog(@"Photo fetch failed?");
        }
    }];
    NSBlockOperation *completionOp = [NSBlockOperation blockOperationWithBlock:^{
        NSError *customError = [NSError errorWithDomain:NSURLErrorDomain code:-1 userInfo:nil];
        if (fetchOp.error) {
            completion(nil, fetchOp.error);
            return;
        }
        if (fetchOp.image == nil && !fetchOp.isCancelled) {
            NSLog(@"Unknown error fetching photo for referenceID %@", photoIDNumber);
            completion(nil, customError);
            return;
        }
        completion(fetchOp.image, nil);
        [self.fetchOperations removeObjectForKey:photoIDNumber];
    }];

    [cacheOp addDependency:fetchOp];
    [completionOp addDependency:fetchOp];

    [self.fetchQueue addOperation:fetchOp];
    [self.fetchQueue addOperation:cacheOp];
    [NSOperationQueue.mainQueue addOperation:completionOp];

    [self.fetchOperations setObject:fetchOp forKey:photoIDNumber];
}

- (void)cancelPhotoFetchForReference:(JBPhotoReference *)photoRef
{
    if (photoRef) {
        NSNumber *photoIDNumber = [NSNumber numberWithUnsignedInteger:photoRef.photoID];
        if (self.fetchOperations[photoIDNumber]) {
            [self.fetchOperations[photoIDNumber] cancel];
        }
    }
}

#pragma mark - Helpers

- (NSMutableArray<JBSol *> *)decodeSolsFromDictionary:(NSDictionary *)dictionary
{
    NSDictionary *manifestDict = dictionary[@"photo_manifest"];
    NSArray *solRefs = manifestDict[@"photos"];

    NSMutableArray *sols = [@[] mutableCopy];
    for (NSDictionary *solRef in solRefs) {
        JBSol *sol = [[JBSol alloc] initWithDictionary:solRef
                                  usingPhotoController:self];
        [sols addObject:sol];
    }
    return sols;
}

@end

