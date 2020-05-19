//
//  LYDPhotoController.m
//  LYDAstronomyObjC
//
//  Created by Lydia Zhang on 5/18/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

#import "LYDPhotoController.h"
#import "LYDAstronomyObjC-Swift.h"
#import "LYDRover.h"

@interface LYDPhotoController()
@property NSURL *baseURL;
@property NSString *key;
@end


@implementation LYDPhotoController

- (instancetype)init {
    self = [super init];
    if (self){
        _baseURL = [[NSURL alloc]initWithString:@"https://api.nasa.gov/mars-photos/api/v1"];
        _key = [[NSString alloc]initWithString:@"IjCchzjn0EuNgmVSr824DPsW57IXpXMwg7bS9mnc"];
        _photoArray = @[];
    }
    return self;
}

- (NSURL *)manifestFromRoverURL:(NSString *)rover {
    
    NSURL *url = self.baseURL;
    url = [url URLByAppendingPathComponent:@"manifests"];
    url = [url URLByAppendingPathComponent:rover];
    
    NSURLComponents *component = [[NSURLComponents alloc]initWithURL:url resolvingAgainstBaseURL:YES];
    [component setQueryItems:@[[NSURLQueryItem queryItemWithName:@"api_key" value:self.key]]];
    
    return component.URL;
}

- (NSURL *)photosFromRoverURL:(NSString *)rover sol:(NSNumber *)sol {
    NSURL *url = self.baseURL;
    url = [url URLByAppendingPathComponent:@"rovers"];
    url = [url URLByAppendingPathComponent:rover];
    url = [url URLByAppendingPathComponent:@"photos"];
    
    NSURLComponents *component = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:true];
    [component setQueryItems:@[
        [NSURLQueryItem queryItemWithName:@"sol" value:[sol stringValue]],
        [NSURLQueryItem queryItemWithName:@"api_key" value:self.key]
    ]];
    
    return component.URL;
}

- (void)fetchManifestFromRover:(NSString *)rover completion:(completion)completion{
    NSURL *url = [self manifestFromRoverURL: rover];
        
    [[[NSURLSession sharedSession] dataTaskWithURL:url
                                    completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
            
            if (error) {
                NSLog(@"Error fetching manifest");
                completion(nil);
                return;
            }

            NSError *jsonError = nil;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            if (jsonError) {
                NSLog(@"Manifest JSON Error: %@", jsonError);
                completion(nil);
                return;
            }
            
            LYDRover *rover = [[LYDRover alloc] initWithDictionary:json];

            completion(@[rover]);
        }] resume];
}

- (void)fetchPhotosFromRover:(NSString *)rover sol:(NSNumber *)sol completion:(completion)completion {
    NSURL *url = [self photosFromRoverURL:rover sol:sol];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url
                                completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        
        if (error) {
            NSLog(@"Error fetching photo");
            completion(nil);
            return;
        }

        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            NSLog(@"Photo JSON Error: %@", jsonError);
            completion(nil);
            return;
        }
         
        NSArray *photos = json[@"photos"];
        NSMutableArray *photosArray = [[NSMutableArray alloc] init];
        
        if (![photos isKindOfClass:NSNull.self]) {
            for (NSDictionary *photoDictionary in photos) {
                [photosArray addObject:[[LYDPhoto alloc] initWithPhotoDictionary:photoDictionary]];
            }
            
            self.photoArray = [photosArray copy];
            completion(photosArray);
        }
        
        completion(nil);
    }] resume];
}

@end
