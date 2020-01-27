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
- (void)fetchMissionManifest;
- (NSMutableArray<JBSol *> *)decodeSolsFromDictionary:(NSDictionary *)dictionary;

@end


@implementation JBPhotoController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _mutableSols = [@[] mutableCopy];
        _networkManager = [[JBNetworkManager alloc] init];
        _networkManager.acceptNilData = NO;
        [self fetchMissionManifest];
    }
    return self;
}

- (NSArray<JBSol *> *)sols
{
    return [self.mutableSols copy];
}

- (void)fetchMissionManifest {
    NSURL *url = [[NSURL URLWithString:baseURLString]
                  URLByAppendingPathComponent:@"manifests/curiosity"];
    [url setValue:kAPIKey forKey:@"api_key"];

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [[self.networkManager fetchDictionaryWithRequest:request
                                          completion:^(NSDictionary * _Nullable dictionary,
                                                       NSError * _Nullable error)
    {
        if (error) {
            NSLog(@"Error fetching manifest: %@", error);
            return;
        }
        if (dictionary == nil) {
            NSLog(@"Error: manifest dictionary is nil");
            return;
        }

        self.mutableSols = [self decodeSolsFromDictionary:dictionary];
    }] resume];
}

- (void)fetchPhotoReferencesForSol:(JBSol *)sol
                        completion:(void (^)(NSMutableArray<JBPhotoReference *> *,
                                             NSError *))completion
{
    NSURL *url = [[NSURL URLWithString:baseURLString]
                  URLByAppendingPathComponent:@"rovers/curiosity/photos"];
    [url setValue:kAPIKey forKey:@"api_key"];
    [url setValue:[NSNumber numberWithUnsignedInteger:sol.solIndex] forKey:@"sol"];

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
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

