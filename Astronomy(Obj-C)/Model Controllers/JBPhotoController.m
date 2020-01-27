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


static NSString *baseURLString = @"https://api.nasa.gov/mars-photos/api/v1";
static NSString *kAPIKey = @"IK5EXzl5H70cLbyq5Jyp4bM8eN9icJNHzpBygHiF";


@interface JBPhotoController()

@property (nonatomic) JBNetworkManager *networkManager;
-(void)fetchMissionManifest;

@end


@implementation JBPhotoController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _networkManager = [[JBNetworkManager alloc] init];
        _networkManager.acceptNilData = NO;
        [self fetchMissionManifest];
    }
    return self;
}

- (void)fetchMissionManifest {
    NSURL *url = [[NSURL URLWithString:baseURLString]
                  URLByAppendingPathComponent:@"manifests/curiosity"];
    [url setValue:kAPIKey forKey:@"api_key"];

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [[self.networkManager fetchDataWithRequest:request
                                    completion:^(NSData * _Nullable data,
                                                 NSError * _Nullable error)
    {
        if (error) {
            NSLog(@"Error fetching manifest: %@", error);
            return;
        }
        if (data == nil) {
            NSLog(@"Error; expected data");
            return;
        }

        NSError *jsonError = nil;
        NSDictionary *dictionary = [NSJSONSerialization
                                    JSONObjectWithData:data
                                    options:0
                                    error:&jsonError];
        if (jsonError) {
            NSLog(@"Error decoding manifest");
            return;
        }

        if (![dictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON was not a dictionary as expected");
            return;
        }
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
    [[self.networkManager fetchDataWithRequest:request
                                    completion:^(NSData * _Nullable data,
                                                 NSError * _Nullable error)
    {
        if (error)
    }] resume];
}

@end

