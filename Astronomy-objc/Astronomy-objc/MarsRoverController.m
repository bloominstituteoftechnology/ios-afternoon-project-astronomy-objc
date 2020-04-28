//
//  MarsRoverManifestController.m
//  Astronomy-objc
//
//  Created by Dillon P on 4/27/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

#import "MarsRoverController.h"
#import "Astronomy_objc-Swift.h"


static NSString *const missionManifestURLString = @"https://api.nasa.gov/mars-photos/api/v1/manifests/spirit?api_key=ncS22avI8uLhNGuabNs82L79amxcTAO4mTn9Lv7f";
static NSString *const fetchPhotosURLString = @"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=30&api_key=ncS22avI8uLhNGuabNs82L79amxcTAO4mTn9Lv7f";
static NSString *const singleImageURLString = @"http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/00030/opgs/edr/ncam/NRA_400165599EDR_F0040000NCAM00106M_.JPG";


@implementation MarsRoverController

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
        
        NSDictionary *roverDictionary = [manifestResults valueForKey:@"photo_manifest"];
        Rover *rover = [[Rover alloc] initWithDictionary:roverDictionary];
        
        NSLog(@"%@", rover.name);
        NSLog(@"%@", rover.landingDate);
        NSLog(@"%@", rover.launchDate);
        NSLog(@"%@", rover.sols);
        NSLog(@"%d", rover.maxSol);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(rover, nil);
        });
        
    }] resume];
    
}

- (void)fetchAllPhotosForSol:(int)sol WithCompletionHandler:(FetchAllPhotosCompletionHandler)completionHandler
{
    NSURL *url = [[NSURL alloc] initWithString:fetchPhotosURLString];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error fetching photos: %@", error);
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
