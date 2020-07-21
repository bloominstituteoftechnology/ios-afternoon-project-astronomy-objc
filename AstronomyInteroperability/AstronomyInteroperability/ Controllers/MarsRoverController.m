//
//  MarsRoverController.m
//  AstronomyInteroperability
//
//  Created by Nonye on 7/21/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

#import "MarsRoverController.h"
#import "AstronomyInteroperability-Swift.h"
#import "LSIMarsRoverClient.h"

NSString *marsAPIURL = @"https://api.nasa.gov/mars-photos/api/v1";
NSString *marsAPIKey =  @"gx4gejGcObDmi5dUaoCnhA1c9iQWsRapkFvmdhGc";

@implementation MarsRoverController

- (void)fetchManifestWithCompletionHandler:(ManifestCompletionBlock)completionBlock
{
    NSURL *baseURL = [[NSURL alloc] initWithString:marsAPIURL];
    NSURL *manifestURL = [baseURL URLByAppendingPathComponent:@"manifests/curiosity"];
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:manifestURL resolvingAgainstBaseURL:NO];
    
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"api_key" value:marsAPIKey],
    ];
    
    NSURL *url = urlComponents.URL;
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error fetching mission manifest: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(nil, error);
            });
            return;
        }
        
        NSError *jsonError;
        NSDictionary *manifestResults = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (!manifestResults) {
            NSLog(@"Error fetching mission manifest: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(nil, error);
            });
            return;
        }
        
        NSDictionary *roverDictionary = [manifestResults valueForKey:@"photo_manifest"];
        LSIMarsRoverClient *rover = [[LSIMarsRoverClient alloc] initWithDictionary:roverDictionary];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(rover, nil);
        });
        
    }] resume];
    
}

- (void)fetchPhotosForSol:(int)sol WithCompletionHandler:(FetchPhotosCompletionBlock)completionBlock
{
    NSURL *baseURL = [[NSURL alloc] initWithString:marsAPIURL];
    NSURL *roverPhotosURL = [baseURL URLByAppendingPathComponent:@"rovers/curiosity/photos"];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:roverPhotosURL resolvingAgainstBaseURL:NO];
    
    NSString *solStringValue = [NSString stringWithFormat:@"%d", sol];
    
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"sol" value:solStringValue],
        [NSURLQueryItem queryItemWithName:@"api_key" value:marsAPIKey],
    ];
    
    NSURL *url = urlComponents.URL;
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error fetching photos for url: %@ with error: %@", url, error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(nil, error);
            });
            return;
        }
        
        if (!data) {
            NSLog(@"Error fetching photos: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(nil, error);
            });
            return;
        }
        
        Photos *photos = [Photos addMarsPhotosFrom:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(photos, nil);
        });
        
    }] resume];
}

@end
