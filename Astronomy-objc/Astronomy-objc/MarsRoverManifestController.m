//
//  MarsRoverManifestController.m
//  Astronomy-objc
//
//  Created by Dillon P on 4/27/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

#import "MarsRoverManifestController.h"


static NSString *const missionManifestURLString = @"https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity?api_key=ncS22avI8uLhNGuabNs82L79amxcTAO4mTn9Lv7f";

@implementation MarsRoverManifestController

- (void)fetchMissionManifestWithCompletionHandler:(MissionManifestCompletionHandler)completionHandler
{
    NSURL *url = [[NSURL alloc] initWithString:missionManifestURLString];
    
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
        
        for (NSDictionary *roverDictionary in manifestResults.allValues) {
            Rover *rover = [[Rover alloc] initWithDictionary:roverDictionary];
            NSLog(@"%@", rover.sols);
            NSLog(@"%d", rover.maxSol);
        }
        
        
        
//        Rover *rover = [[Rover alloc] initWithDictionary:roverDictionary];
//        NSLog(@"%@", rover.sols);
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            completionHandler(rover, nil);
//        });
        
    }] resume];
}

@end
