//
//  PhotoFetcherOperation.m
//  AstronomyOBJc
//
//  Created by Kelson Hartle on 7/28/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import "PhotoFetcherOperation.h"
#import "LSIMarsRoverPhotoReference.h"
#import "AstronomyOBJc-Swift.h"

@interface PhotoFetcherOperation ()

@property (nonatomic, readwrite) LSIMarsRoverPhotoReference *photoReference;
@property (nonatomic, copy, nullable) NSData *imageData;
@property (nonatomic, readwrite) NSURLSessionTask *task;

typedef NS_ENUM(int,State) {isReady, isExecuting, isFinished};
@property State state;
@property (nonatomic) NSURLSessionDataTask *dataTask;

@end

@implementation PhotoFetcherOperation

-(instancetype)initWithPhotoReference:(LSIMarsRoverPhotoReference *)photoReference {
    
    self = [super init];
    if (self) {
        _photoReference = photoReference;
        self.state = isReady;
    }
    return self;
}

- (BOOL)isAsynchronous {
    return YES;
}

- (void)start {
    self.state = isExecuting; // Sends a KVO notification
    NSLog(@"Start");
    
    //NSURL *URL = self.photoURL;
    
    NSURLSession *session = [NSURLSession sharedSession];
    //  FIXME: need to figure out how to use https: to make it secure. (url)
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:[[self.photoReference imageSource]usingHTTPS] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching data for \(self.photoReference): %@", error);
            return;
        }
        if (response) {
            NSLog(@"RESPONSE: %@", response);
        }
        self.imageData = data;
        
        self.state = isFinished;
    }];
    [task resume];
    self.dataTask = task;
    
    
}

- (void)cancel {
    [self.dataTask cancel];
    [super cancel];
    
}

- (BOOL)isReady {
    return self.state == isReady;
}

- (BOOL)isExecuting {
    
    return self.state == isExecuting;
}

- (BOOL)isFinished {
    return self.state == isFinished;
}

+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    
    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
    
    if ([key isEqualToString:@"isReady"] || [key isEqualToString:@"isExectuing"] || [key isEqualToString:@"isFinished"]) {
        keyPaths = [keyPaths setByAddingObject:@"state"];
    }
    return keyPaths;
}

@end
