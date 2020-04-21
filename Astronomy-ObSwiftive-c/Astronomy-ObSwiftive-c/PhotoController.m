//
//  PhotoController.m
//  Astronomy-ObSwiftive-c
//
//  Created by Craig Swanson on 4/20/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import "PhotoController.h"
#import "Astronomy_ObSwiftive_c-Swift.h"
#import "LSIErrors.h"

static NSString *const AstronomyRoverPhotosBaseURL = @"https://api.nasa.gov/mars-photos/api/v1/";
static NSString *const APIKeyString = @"SfjvKWsq2nadyrPm5tfc2czHgHH8nyrttAXDqn3y";

@interface PhotoController ()


@end

@implementation PhotoController

- (instancetype)initWithMarsRover:(NSString *)marsRover {
    if (self = [super init]) {
        _marsRover = marsRover;
    }
    return self;
}

-(void)fetchPhotoManifest:(NSString *)roverName completionHandler:(void (^)(PhotoManifest * _Nullable, NSError * _Nullable))completionHandler {
    
    //https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity?api_key=SfjvKWsq2nadyrPm5tfc2czHgHH8nyrttAXDqn3y
    
    NSURL *manifestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/manifests/%@", AstronomyRoverPhotosBaseURL,roverName]];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:manifestURL resolvingAgainstBaseURL:NO];
    
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"api_key" value:APIKeyString]
    ];
    
    NSURL *url = urlComponents.URL;
    NSLog(@"Current url: %@", url);
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error in fetching manifest data: %@", error);
            completionHandler(nil, error);
            
            return;
        }
        
        if (!data) {
            NSError *dataError = errorWithMessage(@"Data is nil from API response", LSIDataNilError);
            completionHandler(nil, dataError);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            completionHandler(nil, jsonError);
            return;
        }
        
        PhotoManifest *roverManifest = [[PhotoManifest alloc] initWithDictionary:jsonData];
        NSLog(@"rover manifest name: %@, photos: %ld", roverManifest.name, (long)roverManifest.total_photos);
        
        completionHandler(roverManifest, nil);
        
    }] resume];
}

@end
