//
//  MBMRoverController.m
//  Astronomy-Objc
//
//  Created by Michael on 3/23/20.
//  Copyright © 2020 Michael. All rights reserved.
//

#import "MBMRoverController.h"
#import "MBMSolInfo.h"
#import "MBMPhoto.h"
#import "MBMCamera.h"
#import "MBMPhotoResults.h"

#import "Astronomy_Objc-Swift.h"

@interface MBMRoverController ()

@end

static NSString *baseURLString = @"https://api.nasa.gov/mars-photos/api/v1";

static NSString *apiKey = @"XmXYMWlVPWhzbE7kCMN08ho7VdpaeEDPpfC5TG2b";

@implementation MBMRoverController


- (instancetype)init {
    self = [super init];
    if (self) {
        
        _photos = [[NSArray alloc] init];
        
    }
    return self;
}

- (void)fetchManifestWithRoverName:(NSString *)roverName completionBlock:(MBMManifestFetcherCompletion)completion {
    
    
    NSURL *url = [[NSURL alloc] initWithString:baseURLString];
    url = [url URLByAppendingPathComponent:@"manifests"];
    url = [url URLByAppendingPathComponent:roverName];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:YES];
    
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey]
    ];
    
    NSURL *manifestURL = urlComponents.URL;
    
    NSLog(@"%@", manifestURL);
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:manifestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching manifest: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
            });
            return;
        }
        if (!data) {
            NSLog(@"Bad or no data returned from data task for manifest.");
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
            });
            return;
        }
        NSError *jsonError = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            NSLog(@"Error decoding manifest from JSON data: %@", jsonError);
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, jsonError);
            });
            return;
        }
//        NSLog(@"JSON: %@", json);
        
        MissionManifest *manifest = [[MissionManifest alloc] initWithDictionary:json];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(manifest, nil);
        });
    }];
    [task resume];
}

- (void)fetchPhotosWithSol:(int)sol
                 roverName:(NSString *)roverName
           completionBlock:(MBMPhotoFetcherCompletion)completion {
    
    NSURL *url = [[NSURL alloc] initWithString:baseURLString];
    url = [url URLByAppendingPathComponent:@"rovers"];
    url = [url URLByAppendingPathComponent:roverName];
    url = [url URLByAppendingPathComponent:@"photos"];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:YES];
    
    NSString *solNumber = [NSString stringWithFormat:@"%i", sol];
    
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"sol" value:solNumber],
        [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey]
    ];
    
    NSURL *photosForSolURL = urlComponents.URL;
    
    NSLog(@"%@", photosForSolURL);
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:photosForSolURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching photos: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
            });
            return;
        }
        if (!data) {
            NSLog(@"Bad or no data returned from data task for photos");
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
            });
            return;
        }
        NSError *jsonError = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            NSLog(@"Error decoding photos from JSON data: %@", jsonError);
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
            });
            return;
        }
//        NSLog(@"JSON: %@", json);
        
        MBMPhotoResults *photoResults = [[MBMPhotoResults alloc] initWithDictionary:json];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(photoResults.photos, nil);
        });
    }];
    [task resume];
}

@end
