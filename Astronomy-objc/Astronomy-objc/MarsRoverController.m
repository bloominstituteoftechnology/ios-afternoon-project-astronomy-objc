//
//  MarsRoverManifestController.m
//  Astronomy-objc
//
//  Created by Dillon P on 4/27/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

#import "MarsRoverController.h"
#import "Astronomy_objc-Swift.h"

static NSString *const marsRoverAPIURL = @"https://api.nasa.gov/mars-photos/api/v1";
static NSString *const marsRoverAPIKey = @"ncS22avI8uLhNGuabNs82L79amxcTAO4mTn9Lv7f";


@implementation MarsRoverController

- (void)fetchMissionManifestWithCompletionHandler:(MissionManifestCompletionHandler)completionHandler
{
    NSURL *baseURL = [[NSURL alloc] initWithString:marsRoverAPIURL];
    NSURL *manifestURL = [baseURL URLByAppendingPathComponent:@"manifests/curiosity"];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:manifestURL resolvingAgainstBaseURL:NO];
    
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"api_key" value:marsRoverAPIKey],
    ];
    
    NSURL *url = urlComponents.URL;
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error fetching mission manifest: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }
        
        NSError *jsonError;
        NSDictionary *manifestResults = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (!manifestResults) {
            NSLog(@"Error fetching mission manifest: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }
        
        NSDictionary *roverDictionary = [manifestResults valueForKey:@"photo_manifest"];
        Rover *rover = [[Rover alloc] initWithDictionary:roverDictionary];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(rover, nil);
        });
        
    }] resume];
}

- (void)fetchAllPhotosForSol:(int)sol WithCompletionHandler:(FetchAllPhotosCompletionHandler)completionHandler
{
    NSURL *baseURL = [[NSURL alloc] initWithString:marsRoverAPIURL];
    NSURL *roverPhotosURL = [baseURL URLByAppendingPathComponent:@"rovers/curiosity/photos"];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:roverPhotosURL resolvingAgainstBaseURL:NO];
    
    NSString *solStringValue = [NSString stringWithFormat:@"%d", sol];
    
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"sol" value:solStringValue],
        [NSURLQueryItem queryItemWithName:@"api_key" value:marsRoverAPIKey],
    ];
    
    NSURL *url = urlComponents.URL;
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error fetching photos for url: %@ with error: %@", url, error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }
        
        if (!data) {
            NSLog(@"Error fetching photos: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }
        
        MarsRoverPhotos *photos = [MarsRoverPhotos createMarsRoverPhotosFrom:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(photos, nil);
        });
        
    }] resume];
}

- (void)fetchSingleImage:(NSString *)imageURLString WithCompletionHandler:(SingleImageCompletionHandler)completionHandler
{
    NSURL *url = [[NSURL alloc] initWithString:imageURLString];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error fetching image: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }
        
        if (!data) {
            NSLog(@"Error with image data: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }
        
        UIImage *image = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(image, nil);
        });
        
    }] resume];
}

@end
