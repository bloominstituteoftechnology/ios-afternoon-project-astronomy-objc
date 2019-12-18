//
//  GIPFetchPhotoOperation.m
//  Astronomy Objc
//
//  Created by Gi Pyo Kim on 12/17/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

#import "GIPFetchPhotoOperation.h"
#import "Astronomy_Objc-Swift.h"
#import "NSURL+GIPSecure.h"

@interface GIPFetchPhotoOperation()

typedef enum {isReady, isExecuting, isFinished} State;

@property State *state;
@property MarsPhoto *photoRef;
@property NSData *imageData;
@property (nullable) NSURLSessionDataTask *dataTask;

@end

@implementation GIPFetchPhotoOperation

- (instancetype)initWithPhotoRef:(MarsPhoto *)photoRef {
    self = [super init];
    if (self) {
        _photoRef = photoRef;
        _state = isReady;
    }
    return self;
}

- (BOOL)isAsynchronous {
    return YES;
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

- (void)start {
    [super start];
    
    self.state = isExecuting;
    NSURL *url = [self.photoRef.imageURL usingHTTPS];
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (self.isCancelled) {
            return;
        }
        if (error) {
            NSLog(@"Error fetching data for %@: %@", self.photoRef, error);
            return;
        }
        if (data) {
            self.imageData = data;
        }
        self.state = isFinished;
    }];
    [task resume];
    self.dataTask = task;
}

- (void)cancel {
    [self.dataTask cancel];
    [super cancel];
}

@end
