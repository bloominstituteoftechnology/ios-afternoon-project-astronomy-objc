//
//  TXCMarsRoverClient.m
//  AstronomyObjc
//
//  Created by Thomas Cacciatore on 7/22/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

#import "TXCMarsRoverClient.h"
#import "TXCSol.h"
#import "AstronomyObjc-Swift.h"

@implementation TXCMarsRoverClient

NSString *apiKey = @"5KgQqJgMjQ0odutTJgNvZbRjh86tV1lSXZBzg3Ri";
static NSString *baseURL = @"https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity?5KgQqJgMjQ0odutTJgNvZbRjh86tV1lSXZBzg3Ri";


- (void)fetchPhotoManifestCompletionBlock:(TXCManifestFetcherCompletionBlock)completionBlock {
    NSURL *url = [NSURL URLWithString:baseURL];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching manifest: %@", error);
            completionBlock(nil, error);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            NSLog(@"JSON Error: %@", jsonError);
            completionBlock(nil, jsonError);
            return;
        }
        
        //        NSLog(@"JSON: %@", json);
        NSArray *photosArray = json[@"photos"]; // Array of dictionary objects
        NSMutableArray *sols = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in photosArray) {
            TXCSol *sol = [[TXCSol alloc] initWithDictionary:dict];
            
            if (sol) {
                [sols addObject:sol];
            }
        }
        completionBlock(sols, nil);
    }];
    [task resume];
}
@end
