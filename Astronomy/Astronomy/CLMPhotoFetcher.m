//
//  CLMPhotoFetcher.m
//  Astronomy
//
//  Created by Claudia Maciel on 8/7/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

#import "CLMPhotoFetcher.h"
#import "CLMPhoto.h"
#import "CLMPhotoResult.h"
#import "LSIErrors.h"
#import "LSILog.h"


////https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY
static NSString *baseURLString = @"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?";
static NSString *APIKey = @"UGalbvgVb4Ncm7dqd6ZQpDAZneeW0232rsZyAlH";

@implementation CLMPhotoFetcher

- (void)fetchPhotosFromSol:(NSNumber *)sol completion:(CLMPhotoFetcherCompletion)completion
{
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:baseURLString];
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"sol" value:[NSString stringWithFormat:@"%@", sol]],
        [NSURLQueryItem queryItemWithName:@"api_key" value:APIKey]
    ];

    NSURL *url = urlComponents.URL;

    if (url) {
        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                completion(nil, error);
                return;
            }

            if (data == nil) {
                NSError *dataError = errorWithMessage(@"Unable to retrieve data", LSIDataNilError);
                completion(nil, dataError);
                return;
            }

            NSError *jsonError = nil;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

            if (jsonError) {
                completion(nil, jsonError);
                return;
            }

            CLMPhotoResult *photoResults = [[CLMPhotoResult alloc] initWithDictionary:json];
            completion(photoResults.photos, nil);
        }];

        [task resume];
    } else {
        NSLog(@"Invalid URL");
    }
}

@end
