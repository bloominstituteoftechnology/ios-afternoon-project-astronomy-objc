//
//  FetchManifest.m
//  Astronomy-objc
//
//  Created by Matthew Martindale on 8/5/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

#import "FetchManifest.h"
#import "MarsPhotoReference.h"
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
        
        Rover *manifestInfo = [[Rover alloc] initWithDictionary:manifestDictionary];
        if (!manifestInfo) {
            NSLog(@"Error parsing Rover data: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(manifestInfo, nil);
        });
        
    }]resume];
}

- (void)fetchPhotosFromRover:(Rover *)marsRover onSol:(int)sol completionHandler:(FetchMarsPhotosCompletionHandler)completionHandler
{
    if (!completionHandler) return;
    
    NSURL *baseURL = [NSURL URLWithString:@"https://api.nasa.gov/mars-photos/api/v1/rovers"];
    NSURL *url = [[baseURL URLByAppendingPathComponent:marsRover.name]
                  URLByAppendingPathComponent:@"photos"];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    NSURLQueryItem *solItem = [NSURLQueryItem queryItemWithName:@"sol" value:[@(sol) stringValue]];
    NSURLQueryItem *apiKeyItem = [NSURLQueryItem queryItemWithName:@"api_key" value:APIKey];
    urlComponents.queryItems = @[solItem, apiKeyItem];
    
    NSURL *requestURL = urlComponents.URL;
    NSLog(@"URL: %@", requestURL);
    
    [[NSURLSession.sharedSession dataTaskWithURL:requestURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error fetching photos for rover: %@, on sol: %d", marsRover, sol);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }
        
        NSError *jsonError;
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (!jsonDictionary) {
            NSLog(@"Error decoding JSON: %@", jsonError);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, jsonError);
            });
            return;
        }
        
        NSArray *photoReferenceDictionaries = [[NSArray alloc] initWithArray:[jsonDictionary valueForKey:@"photos"]];
        if (!photoReferenceDictionaries) {
            NSLog(@"Error creating photo reference dictionary");
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }
        
        NSMutableArray *photoReferences = [[NSMutableArray alloc] initWithCapacity:photoReferenceDictionaries.count];
        
        for (NSDictionary *photoReferenceDictionary in photoReferenceDictionaries) {
            if (![photoReferenceDictionary isKindOfClass:NSDictionary.class]) continue;
            
            MarsPhotoReference *marsPhotoReference = [[MarsPhotoReference alloc] initWithDictionary:photoReferenceDictionary];
            
            if (marsPhotoReference) {
                [photoReferences addObject:marsPhotoReference];
            } else {
                NSLog(@"Unable to parse photoReference dictionary: %@", photoReferenceDictionary);
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(photoReferences, nil);
        });
        
    }]resume];
}

@end
