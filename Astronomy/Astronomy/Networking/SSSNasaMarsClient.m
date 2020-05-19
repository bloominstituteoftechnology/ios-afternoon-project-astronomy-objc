//
//  SSSNasaMarsClient.m
//  Astronomy
//
//  Created by Shawn Gee on 5/18/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import "SSSNasaMarsClient.h"
#import "SSSPhotoManifest.h"
#import "SSSMarsSol.h"
#import "SSSMarsPhoto.h"
#import "LSIErrors.h"

static NSString *baseUrlString = @"https://api.nasa.gov/mars-photos/api/v1/";
static NSString *apiKey = @"qzGsj0zsKk6CA9JZP1UjAbpQHabBfaPg2M5dGMB7";

@implementation SSSNasaMarsClient

- (void)fetchManifestForRoverNamed:(NSString *)roverName
                                      completion:(SSSFetchManifestCompletion)completion {
    NSURL *url = [[NSURL URLWithString:baseUrlString] URLByAppendingPathComponent:@"manifests"];
    url = [url URLByAppendingPathComponent:roverName];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey],
    ];
    url = urlComponents.URL;
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error) {
            completion(nil, error);
            return;
        }

        if (!data) {
            NSError *dataError = errorWithMessage(@"No artist data returned", LSIDataNilError);
            completion(nil, dataError);
            return;
        }

        NSError *jsonError = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

        if (jsonError) { // jsonError != nil
            completion(nil, jsonError);
            return;
        }
        
        NSDictionary *photoManifestDict = dictionary[@"photo_manifest"];
        SSSPhotoManifest *photoManifest = [[SSSPhotoManifest alloc] initWithDictionary:photoManifestDict];
        completion(photoManifest, nil);
    }];
    
    [task resume];
}

- (void)fetchPhotosForRoverNamed:(NSString *)roverName
                           onSol:(SSSMarsSol *)sol
                      completion:(SSSFetchPhotosCompletion)completion {
    NSURL *url = [[NSURL URLWithString:baseUrlString] URLByAppendingPathComponent:@"rovers"];
    url = [url URLByAppendingPathComponent:roverName];
    url = [url URLByAppendingPathComponent:@"photos"];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"sol" value:[NSString stringWithFormat:@"%d", sol.solNumber]],
        [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey],
    ];
    url = urlComponents.URL;
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error) {
            completion(nil, error);
            return;
        }

        if (!data) {
            NSError *dataError = errorWithMessage(@"No artist data returned", LSIDataNilError);
            completion(nil, dataError);
            return;
        }

        NSError *jsonError = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

        if (jsonError) { // jsonError != nil
            completion(nil, jsonError);
            return;
        }
        
        NSArray<NSDictionary *> *photoDicts = dictionary[@"photos"];
        NSMutableArray<SSSMarsPhoto *> *photos = [[NSMutableArray alloc] init];
        
        for (NSDictionary *photoDict in photoDicts) {
            [photos addObject:[[SSSMarsPhoto alloc] initWithDictionary:photoDict]];
        }
        
        completion([photos copy], nil);
    }];
    
    [task resume];
}

@end
