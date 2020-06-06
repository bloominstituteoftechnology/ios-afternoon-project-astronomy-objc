//
//  CATMarsRoverClient.m
//  Astronomy
//
//  Created by Jessie Ann Griffin on 6/5/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

#import "CATMarsRoverClient.h"

@interface CATMarsRoverClient ()



@end

@implementation CATMarsRoverClient

- (void)fetchMarsRoverWithName:(NSString *)name completion:(MarsRoverCompletion)completion
{

}

- (void)saveMarsRoverToLocal:(MarsRoverCompletion)completion
{

}

- (void)fetchPhotosFrom:(CATMarsRover *)rover onSol:(int)sol completion:(MarsPhotosCompletion)photos
{

}

- (void)fetchLocalPhotosFrom:(CATMarsRover *)rover onSol:(int)sol completion:(MarsPhotosCompletion)photos
{

}

- (NSURL *)URLforInfoForRover:(NSString *)roverName
{
    NSURL *baseURL = [NSURL URLWithString:@"https://api.nasa.gov/mars-photos/api/v1"];
    NSString *apiKey = @"dbK4pfi2Sb18KBfNPjlhYTeIcd5GyVIzwqzIAa5K";
    [baseURL URLByAppendingPathComponent:@"manifests"];
    [baseURL URLByAppendingPathComponent:roverName];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:@"api_key" value:apiKey]];
    NSURL *url = urlComponents.URL;
    return url;
}

- (NSURL *)URLforPhotosFromRover:(NSString *)roverName onSol:(int)sol
{
    NSURL *baseURL = [NSURL URLWithString:@"https://api.nasa.gov/mars-photos/api/v1"];
    NSString *apiKey = @"dbK4pfi2Sb18KBfNPjlhYTeIcd5GyVIzwqzIAa5K";
    [baseURL URLByAppendingPathComponent:@"rovers"];
    [baseURL URLByAppendingPathComponent:roverName];
    [baseURL URLByAppendingPathComponent:@"photos"];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"sol" value:[NSString stringWithFormat:@"%d", sol]],
        [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey],
    ];
    NSURL *url = urlComponents.URL;
    return url;
}


@end
