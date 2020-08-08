//
//  MarsRoverClient.m
//  Astronomy-ObjC
//
//  Created by Chad Parker on 8/7/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import "MarsRoverClient.h"
#import "Astronomy_ObjC-Swift.h"

static NSString *const MarsPhotosBaseURLString = @"https://api.nasa.gov/mars-photos/api/v1";
static NSString *const MarsPhotosAPIKeyString = @"qzGsj0zsKk6CA9JZP1UjAbpQHabBfaPg2M5dGMB7";

@implementation MarsRoverClient

- (void)fetchMarsRoverNamed:(NSString *)name completion:(FetchMarsRoverCompletionHandler)completion
{
    
}

- (NSURL *)urlForRover:(NSString *)roverName
{
    NSURL *baseURL = [NSURL URLWithString:MarsPhotosBaseURLString];
    NSURL *url = [[baseURL URLByAppendingPathComponent:@"manifests"] URLByAppendingPathComponent:roverName];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:@"api_key" value:MarsPhotosAPIKeyString]];
    return urlComponents.URL;
}

@end
