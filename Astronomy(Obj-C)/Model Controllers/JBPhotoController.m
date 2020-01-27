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


static NSString *baseURLString = @"https://api.nasa.gov/mars-photos/api/v1";
static NSString *kAPIKey = @"IK5EXzl5H70cLbyq5Jyp4bM8eN9icJNHzpBygHiF";


@interface JBPhotoController()

@property (nonatomic, nonnull) JBNetworkManager *networkManager;
@property (nonatomic, nonnull) NSMutableArray<JBSol *> *mutableSols;
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
    }
    return self;
}

- (NSArray<JBSol *> *)sols
{
    return [self.mutableSols copy];
}

# pragma mark - Public API

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
            completion([[NSError alloc] init]);
            return;
        }

        self.mutableSols = [self decodeSolsFromDictionary:dictionary];
        completion(nil);
    }] resume];
}

- (void)fetchPhotoReferencesForSol:(JBSol *)sol
                        completion:(void (^)(NSMutableArray<JBPhotoReference *> *,
                                             NSError *))completion
{
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
            completion(nil, [[NSError alloc] init]);
            return;
        }

        NSArray *photoRefDicts = dictionary[@"photos"];
        NSMutableArray *photoRefs = [@[] mutableCopy];
        for (NSDictionary *photoRefDict in photoRefDicts) {
            JBPhotoReference *photoRef = [[JBPhotoReference alloc]
                                          initFromDictionary:photoRefDict];
            [photoRefs addObject:photoRef];
        }
        completion(photoRefs, nil);
    }] resume];
}

- (void)fetchPhotoForReference:(JBPhotoReference *)photoRef
                    completion:(void (^)(UIImage *,
                                         NSError *))completion
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:photoRef.imageURL];
    [[self.networkManager fetchDataWithRequest:request
                                    completion:^(NSData * _Nullable data,
                                                 NSError * _Nullable error)
    {
        if (error) {
            completion(nil, error);
            return;
        }
        if (data == nil) {
            NSLog(@"Error: sol photo data is nil");
            completion(nil, [[NSError alloc] init]);
            return;
        }

        UIImage *image = [UIImage imageWithData:data];
        completion(image, nil);
    }] resume];
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

