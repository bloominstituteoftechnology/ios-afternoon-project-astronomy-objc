//
//  ManifestFetcher.m
//  AstronomyObjC
//
//  Created by Nick Nguyen on 4/22/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

#import "ManifestFetcher.h"
#import "LSILog.h"
#import "LSIErrors.h"
#import "SolManifest.h"
//https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity?api_key=E1mvXHcz2wixp2XkoacEfdqeZUomUQZXNdm4j13Z

@implementation ManifestFetcher

static NSString *baseURLString = @"https://api.nasa.gov/mars-photos/api/v1/manifests";
static NSString *apiKey = @"HawdkeoyrsCNZTu0DtPL4loF7dhLOOj259yzrktr";


- (void)fetchManifestForRover:(NSString *_Nullable)rover completion:(ManifestFetcherCompletion _Nullable)completion {
    NSURL *baseURL = [[[NSURL alloc ]initWithString:baseURLString]
                      URLByAppendingPathComponent:rover];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[
    [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey]
    ];
    NSURL *url = urlComponents.URL;
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil,error);
            });
            return ;
        }
        NSLog(@"%@",url);
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            dispatch_async(dispatch_get_main_queue(), ^ {
                completion(nil,jsonError);
            });
            return;
        }
        SolManifest *manifest = [[SolManifest alloc]initWithDictionary:json];
        if (!manifest) {
            NSError *parsingError = errorWithMessage(@"Unable to parse JSON object", LSIJSONDecodeError);
            dispatch_async(dispatch_get_main_queue(), ^ {
                completion(nil,parsingError);
            });
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            completion(manifest,nil);
        });
        
   
    }] resume];
}

@end
