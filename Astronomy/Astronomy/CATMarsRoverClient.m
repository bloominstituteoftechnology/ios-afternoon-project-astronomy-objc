//
//  CATMarsRoverClient.m
//  Astronomy
//
//  Created by Jessie Ann Griffin on 6/5/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

#import "CATMarsRoverClient.h"

static NSString *const stringForBaseURL = @"https://api.nasa.gov/mars-photos/api/v1";
static NSString *const apiKey = @"dbK4pfi2Sb18KBfNPjlhYTeIcd5GyVIzwqzIAa5K";

@interface CATMarsRoverClient ()

- (void)fetch:(id)object fromURL:(NSURL *)url completion:(GenericCompletion)completion;

@end

@implementation CATMarsRoverClient

- (void)fetchMarsRoverWithName:(NSString *)roverName completion:(MarsRoverCompletion)completion
{
    NSURL *url = [self URLforInfoForRover:roverName];
    [[NSURLSession.sharedSession dataTaskWithURL:url
                               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error fetching rover: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
            });
            return;
        }

        NSError *jsonError;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (!dictionary) {
            NSLog(@"Error decoding json %@", jsonError);
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, jsonError);
            });
            return;
        }

        CATMarsRover *results = [[CATMarsRover alloc] initWithDictionary:dictionary];
        if (!results) {
            NSError *error = [NSError errorWithDomain:@"com.LambdaSchool.Astronomy.ErrorDomain" code:-1 userInfo:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
            });
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(results, nil);
        });


        

    }] resume];
}

- (void)saveMarsRoverToLocal:(MarsRoverCompletion)completion
{

}

- (void)fetchPhotosFrom:(CATMarsRover *)rover onSol:(int)sol completion:(MarsPhotosCompletion)completion
{

}

- (void)fetchLocalPhotosFrom:(CATMarsRover *)rover onSol:(int)sol completion:(MarsPhotosCompletion)completion
{

}

- (void)fetchFromURL:(NSURL *)url completion:(GenericCompletion)completion
{

}

- (NSURL *)URLforInfoForRover:(NSString *)roverName
{
    NSURL *baseURL = [NSURL URLWithString:stringForBaseURL];
    [baseURL URLByAppendingPathComponent:@"manifests"];
    [baseURL URLByAppendingPathComponent:roverName];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:@"api_key" value:apiKey]];
    NSURL *url = urlComponents.URL;
    return url;
}

- (NSURL *)URLforPhotosFromRover:(NSString *)roverName onSol:(int)sol
{
    NSURL *baseURL = [NSURL URLWithString:stringForBaseURL];
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
