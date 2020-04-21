//
//  PhotoController.m
//  Astronomy-ObSwiftive-c
//
//  Created by Craig Swanson on 4/20/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import "PhotoController.h"

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
    
    
}

@end
