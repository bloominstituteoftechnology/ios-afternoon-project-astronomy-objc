//
//  CARManifestFetcher.m
//  CARAstronomy
//
//  Created by Chad Rutherford on 2/24/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import "CARManifestFetcher.h"
#import "CARMarsMissionManifest.h"
#import "LSIErrors.h"
#import "LSILog.h"

@implementation CARManifestFetcher

// https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity?api_key=E1mvXHcz2wixp2XkoacEfdqeZUomUQZXNdm4j13Z
static NSString *const baseURLString = @"https://api.nasa.gov/mars-photos/api/v1/manifests";
static NSString *const apiKey = @"E1mvXHcz2wixp2XkoacEfdqeZUomUQZXNdm4j13Z";

- (void)fetchManifestForRover:(NSString *)rover
                   completion:(CARMainfestFetcherCompletion)completion {
    NSURL *baseURL = [[[NSURL alloc] initWithString:baseURLString] URLByAppendingPathComponent:rover];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey]
    ];
    NSURL *url = urlComponents.URL;
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
            });
            return;
        }
        
        if (!data) {
            NSError *dataError = errorWithMessage(@"Data should not be nil from API request.", LSIDataNilError);
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, dataError);
            });
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, jsonError);
            });
            return;
        }
        
        CARMarsMissionManifest *manifest = [[CARMarsMissionManifest alloc] initWitihDictionary:json];
        if (!manifest) {
            NSError *parsingError = errorWithMessage(@"Unable to parse JSON object", LSIJSONDecodeError);
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, parsingError);
            });
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(manifest, nil);
        });
    }] resume];
}
@end
