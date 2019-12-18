//
//  GIPMarsRoverClient.m
//  Astronomy Objc
//
//  Created by Gi Pyo Kim on 12/17/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

#import "GIPMarsRoverClient.h"
#import "GIPMarsRover.h"
#import "Astronomy_Objc-Swift.h"

@interface GIPMarsRoverClient()

@property NSMutableArray<MarsPhoto *> *internalPhotos;

@end

@implementation GIPMarsRoverClient

static NSString *const baseURLString = @"https://api.nasa.gov/mars-photos/api/v1";
static NSString *const APIKey = @"3TuvoId3HudPSG0ih3fTuTgubVE0fCP7NmgC4Wg5";

- (instancetype)init
{
    self = [super init];
    if (self) {
        _internalPhotos = [[NSMutableArray alloc] init];
    }
    return self;
}

//- (void)setPhotos:(NSArray<MarsPhoto *> *)photos {
//    _photos = self.internalPhotos;
//}

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
        
        if (error) {
            completion(nil, error);
            return;
        }
        
        if (data == nil) {
            completion(nil, [[NSError alloc] initWithDomain:@"com.gipyokim.Astronomy-Objc" code:0 userInfo:@{@"Error reason": @"Data returned nil."}]);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            completion(nil, jsonError);
            return;
        }
        
        if (![json isKindOfClass:[NSDictionary class]]) {
            completion(nil, [[NSError alloc] initWithDomain:@"com.gipyokim.Astronomy-Objc" code:0 userInfo:@{@"Error reason": @"NJSON was not a top level dictionary as expected."}]);
            return;
        }
        
        NSDictionary *resultDict = json[@"photo_manifest"];
        GIPMarsRover *rover = [[GIPMarsRover alloc] initWithDictionary:resultDict];
        completion(rover,nil);
        
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
        
        if (error) {
            completion(nil, error);
            return;
        }
        
        if (data == nil) {
            completion(nil, [[NSError alloc] initWithDomain:@"com.gipyokim.Astronomy-Objc" code:0 userInfo:@{@"Error reason": @"Data returned nil."}]);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            completion(nil, jsonError);
            return;
        }
        
        if (![json isKindOfClass:[NSDictionary class]]) {
            completion(nil, [[NSError alloc] initWithDomain:@"com.gipyokim.Astronomy-Objc" code:0 userInfo:@{@"Error reason": @"NJSON was not a top level dictionary as expected."}]);
            return;
        }
        
        NSArray *resultArray = json[@"photos"];
        for (NSDictionary *dict in resultArray) {
            [self.internalPhotos addObject:[[MarsPhoto alloc] initWithDictionary:dict]];
        }

        completion(self.internalPhotos, nil);
        
    }];
    [task resume];
}


@end
