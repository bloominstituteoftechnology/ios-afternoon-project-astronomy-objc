//
//  GIPMarsRoverClient.m
//  Astronomy Objc
//
//  Created by Gi Pyo Kim on 12/17/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

#import "GIPMarsRoverClient.h"
#import "Astronomy_Objc-Swift.h"

@implementation GIPMarsRoverClient

static NSString *const baseURLString = @"https://api.nasa.gov/mars-photos/api/v1";
static NSString *const APIKey = @"3TuvoId3HudPSG0ih3fTuTgubVE0fCP7NmgC4Wg5";

- (void)fetchRover:(NSString *)rover completion:(void (^)(GIPMarsRover *rover, NSError *error))completion {
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    baseURL = [baseURL URLByAppendingPathComponent:@"manifests"];
    baseURL = [baseURL URLByAppendingPathComponent:rover];
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    
    NSURLQueryItem *apiKey = [NSURLQueryItem queryItemWithName:@"api_key" value:APIKey];
    [components setQueryItems:@[apiKey]];
     
    NSURL *url = [components URL];
    NSLog(@"ROVER URL: %@", url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    [task resume];
}



- (void)fetchPhoto:(NSString *)rover sol:(int)sol completion:(void (^)(NSArray<MarsPhoto *> *photos, NSError *error))completion {
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    baseURL = [baseURL URLByAppendingPathComponent:@"rovers"];
    baseURL = [baseURL URLByAppendingPathComponent:rover];
    baseURL = [baseURL URLByAppendingPathComponent:@"photos"];

    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    
    NSURLQueryItem *onSol = [NSURLQueryItem queryItemWithName:@"sol" value:[NSString stringWithFormat:@"%d", (sol)]];
    NSURLQueryItem *apiKey = [NSURLQueryItem queryItemWithName:@"api_key" value:APIKey];
    [components setQueryItems:@[onSol, apiKey]];
     
    NSURL *url = [components URL];
    NSLog(@"PHOTO URL: %@", url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    [task resume];
}


@end
