//
//  LSIMarsRoverClient.m
//  Astronomy-Hybrid
//
//  Created by Isaac Lyons on 12/16/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

#import "LSIMarsRoverClient.h"
#import "LSIMarsRover.h"
#import "Astronomy_Hybrid-Swift.h"

@implementation LSIMarsRoverClient

- (instancetype)init
{
    self = [super init];
    if (self) {
        _baseURL = [NSURL URLWithString:@"https://api.nasa.gov/mars-photos/api/v1"];
        _apiKey = @"n89mZOoeAiBz6aHKu0inS0uiAYhWT3A97c6ZYBW5";
    }
    return self;
}

- (void)fetchFromURL:(NSURL *)url completion:(void (^)(NSDictionary * _Nullable, NSError * _Nullable))completion {
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            completion(nil, error);
            return;
        }
        
        if (data == nil) {
            NSLog(@"Data was nil");
            completion(nil, nil);
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            completion(nil, error);
            return;
        }
        
        if (![json isKindOfClass:[NSDictionary class]]) { // Could be NSArray or NSNull
            NSLog(@"JSON was not a top-level dictionary as expected");
            completion(nil, nil);
        }
        
        completion(json, nil);
    }];
    
    [task resume];
}

- (void)fetchMarsRoverNamed:(NSString *)name completion:(void (^)(LSIMarsRover * _Nullable, NSError * _Nullable))completion {
    
    NSURL *url = [self urlForRoverNamed:name];
    NSLog(@"%@", [url description]);
    
    [self fetchFromURL:url completion:^(NSDictionary * _Nullable dictionary, NSError * _Nullable error) {
        //NSLog(@"Fetched!");
        if (error) {
            return completion(nil, error);
        }
        
        NSDictionary *manifest = dictionary[@"photo_manifest"];
        
        completion([[LSIMarsRover alloc] initWithDictionary:manifest], nil);
    }];
}

- (void)fetchPhotosFromRover:(LSIMarsRover *)rover onSol:(int)sol completion:(void (^)(NSArray<MarsPhotoReference *> * _Nullable, NSError * _Nullable))completion {
    
    NSURL * url = [self urlForPhotosFromRoverNamed:[rover name] onSol:sol];
    NSLog(@"%@", [url description]);
    
    [self fetchFromURL:url completion:^(NSDictionary * _Nullable dictionary, NSError * _Nullable error) {
        if (error) {
            return completion(nil, error);
        }
        
        NSArray *photosJSON = dictionary[@"photos"];
        
        NSMutableArray<MarsPhotoReference *> *photos = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in photosJSON) {
            MarsPhotoReference *photo = [[MarsPhotoReference alloc] initWith:dictionary];
            if (photo) {
                [photos addObject:photo];
            }
        }
        
        completion(photos, nil);
    }];
}

- (NSURL *)urlForRoverNamed:(NSString *)name {
    NSURL *url = [[self.baseURL
                   URLByAppendingPathComponent:@"manifests"]
                  URLByAppendingPathComponent:name];
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    NSURLQueryItem *apiKeyItem = [NSURLQueryItem queryItemWithName:@"api_key" value:self.apiKey];
    [components setQueryItems:@[apiKeyItem]];
    
    return [components URL];
}

- (NSURL *)urlForPhotosFromRoverNamed:(NSString *)name
                                onSol:(int)sol {
    NSURL *url = [[[self.baseURL
                    URLByAppendingPathComponent:@"rovers"]
                   URLByAppendingPathComponent:name]
                  URLByAppendingPathComponent:@"photos"];
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    NSURLQueryItem *apiKeyItem = [NSURLQueryItem queryItemWithName:@"api_key" value:self.apiKey];
    NSURLQueryItem *solItem = [NSURLQueryItem queryItemWithName:@"sol" value:[NSString stringWithFormat:@"%d", sol]];
    [components setQueryItems:@[apiKeyItem, solItem]];
    
    return [components URL];
}

@end
