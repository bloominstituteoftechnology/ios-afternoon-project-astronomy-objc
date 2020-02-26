//
//  CARSolFetcher.m
//  CARAstronomy
//
//  Created by Chad Rutherford on 2/24/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import "CARSolFetcher.h"
#import "CARMarsSol.h"
#import "LSIErrors.h"
#import "LSILog.h"

@implementation CARSolFetcher

static NSString *const baseURLString = @"https://api.nasa.gov/mars-photos/api/v1/rovers";
static NSString *const apiKey = @"E1mvXHcz2wixp2XkoacEfdqeZUomUQZXNdm4j13Z";

- (void)fetchPhotosForRover:(NSString *)rover
                    withSol:(NSNumber *)sol
               completion:(CARSolFetcherCompletion)completion {
    NSURL *baseURL = [[[NSURL URLWithString:baseURLString] URLByAppendingPathComponent:rover] URLByAppendingPathComponent:@"photos"];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"sol" value: [NSString stringWithFormat:@"%d", sol.intValue]],
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
        
        NSArray *photosArray = json[@"photos"];
        NSMutableArray *photos = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in photosArray) {
            CARMarsSol *sol = [[CARMarsSol alloc] initWithDictionary:dictionary];
            [photos addObject:sol];
        }
        if (!photos) {
            NSError *parsingError = errorWithMessage(@"Unable to parse JSON objects", LSIJSONDecodeError);
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, parsingError);
            });
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(photos, nil);
        });
    }] resume];
}
@end
