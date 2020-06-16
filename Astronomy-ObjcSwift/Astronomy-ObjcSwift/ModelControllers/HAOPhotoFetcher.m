//
//  HAOPhotoFetcher.m
//  Astronomy-ObjcSwift
//
//  Created by Hunter Oppel on 6/15/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

#import "HAOPhotoFetcher.h"
#import "HAOPhoto.h"
#import "HAOPhotoResult.h"
#import "LSIErrors.h"
#import "LSILog.h"

static NSString *baseURLString = @"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos";
static NSString *apiKey = @"EH9VpLX50kacNbwO9nLVqWgdxxu7Nj2nfa9nYITO";

@implementation HAOPhotoFetcher

- (void)fetchPhotosFromSol:(NSNumber *)sol completion:(HAOPhotoFetcherCompletion)completion
{
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:baseURLString];
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"sol" value:[NSString stringWithFormat:@"%@", sol]],
        [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey]
    ];
    
    NSURL *url = urlComponents.URL;
    
    if (url) {
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
            
            HAOPhotoResult *photoResults = [[HAOPhotoResult alloc] initWithDictionary:json];
            completion(photoResults.photos, nil);
        }];
        
        [task resume];
    } else {
        NSLog(@"⚠️ URL IS BAD ⚠️");
    }
}

@end
