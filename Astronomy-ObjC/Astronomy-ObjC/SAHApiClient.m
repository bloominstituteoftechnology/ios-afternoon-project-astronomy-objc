//
//  SAHApiClient.m
//  Astronomy-ObjC
//
//  Created by scott harris on 4/20/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

#import "SAHApiClient.h"
#import "SAHNasaManifest.h"

static NSString *baseURLString = @"https://api.nasa.gov/mars-photos/api/v1";
static NSString *apiKey = @"rShurQFkW6eGo61RksJec09o5v9PvFRWfb3C00WG";

@implementation SAHApiClient

- (void)fetchManifestWithCompletionBlock:(SAHManifestFetcherCompletionBlock)completionBlock {
    NSURL *url = [[NSURL alloc] initWithString:baseURLString];
    NSURL *fullURL = [url URLByAppendingPathComponent:@"manifests/curiosity"];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:fullURL resolvingAgainstBaseURL:NO];
    
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"API_KEY" value:apiKey]
    ];
    
    NSURL *finalURL = urlComponents.URL;
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
        NSLog(@"URL: %@", finalURL);
        
        if (error) {
            completionBlock(nil, error);
            return;
        }
        
        if (!data) {
            NSError *dataError = [[NSError alloc] initWithDomain:@"com.sah.Astronomy" code:100 userInfo:nil];
            completionBlock(nil, dataError);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        if (jsonError) {
            completionBlock(nil, jsonError);
        }
        
        NSDictionary *manifestDictionary = jsonDictionary[@"photo_manifest"];
        
        SAHNasaManifest *mainfest = [[SAHNasaManifest alloc] initWithDictionary:manifestDictionary];
        
        completionBlock(mainfest, nil);
        
        
    }];
    
    [task resume];
    
}

@end
