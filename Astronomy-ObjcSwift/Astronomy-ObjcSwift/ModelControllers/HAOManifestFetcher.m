//
//  HAOManifestFetcher.m
//  Astronomy-ObjcSwift
//
//  Created by Hunter Oppel on 6/16/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

#import "HAOManifestFetcher.h"
#import "HAOManifest.h"
#import "LSIErrors.h"
#import "LSILog.h"

static NSString *baseURLString = @"https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity?api_key=EH9VpLX50kacNbwO9nLVqWgdxxu7Nj2nfa9nYITO";

@implementation HAOManifestFetcher

- (void)fetchManifestWithCompletion:(HAOManifestFetcherCompletion)completion
{
    NSURL *url = [NSURL URLWithString:baseURLString];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        if (data == nil) {
            NSError *dataError = errorWithMessage(@"Data is nil", LSIDataNilError);
            completion(nil, dataError);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            completion(nil, jsonError);
            return;
        }
        
        HAOManifest *sols = [[HAOManifest alloc] initWithDictionary:json];
        completion(sols.solManifest, nil);
    }];
    
    [task resume];
}

@end
