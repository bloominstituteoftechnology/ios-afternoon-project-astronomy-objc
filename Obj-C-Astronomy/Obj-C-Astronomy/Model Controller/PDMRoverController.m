//
//  PDMRoverController.m
//  Obj-C-Astronomy
//
//  Created by Patrick Millet on 6/16/20.
//  Copyright © 2020 PatrickMillet79. All rights reserved.
//

#import "PDMRoverController.h"
#import "Obj_C_Astronomy-Swift.h"
#import "PDMRover.h"

static NSString *const marsRoverAPIURL = @"https://api.nasa.gov/mars-photos/api/v1";
static NSString *const marsRoverAPIKey = @"rnZpxQ7kz6VUFu049fXKsoWEC4HuuFaEieYGsesJ";


@implementation PDMMarsRoverController

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
        PDMRover *rover = [[PDMRover alloc] initWithDictionary:roverDictionary];
        
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

@end
