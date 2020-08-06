//
//  FetchManifest.m
//  Astronomy-objc
//
//  Created by Matthew Martindale on 8/5/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

#import "FetchManifest.h"
#import "Astronomy_objc-Swift.h"

static NSString *const APIKey = @"CrGyhe4SzkbgKB2Ahw17krmCKU9JbRToEUxkc1Yh";

@implementation FetchManifest

- (void)fetchRoverManifest:(NSString *)roverName completionHandler:(FetchRoverManifestCompletionHandler)completionHandler
{
    if (!completionHandler) return;
    
    NSURL *baseURL = [NSURL URLWithString:@"https://api.nasa.gov/mars-photos/api/v1/manifests"];
    NSURL *url = [baseURL URLByAppendingPathComponent:roverName];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    NSURLQueryItem *apiKeyItem = [NSURLQueryItem queryItemWithName:@"api_key" value:APIKey];
    urlComponents.queryItems = @[apiKeyItem];
    
    NSURL *requestURL = urlComponents.URL;
    
    [[NSURLSession.sharedSession dataTaskWithURL:requestURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error fetching infor for rover: %@", roverName);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }
        
        NSError *jsonError;
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        NSDictionary *manifestDictionary = [jsonDictionary objectForKey:@"photo_manifest"];
        if (!manifestDictionary) {
            NSLog(@"Error decoding JSON: %@", jsonError);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, jsonError);
            });
            return;
        }
        
        Rover *manifestInfo = [[Rover alloc] initWithName:<#(NSString * _Nonnull)#> status:<#(NSString * _Nonnull)#>]
        
    }]resume];
}

@end
