//
//  FetchPhotoOperation.m
//  Astronomy-Interoperability
//
//  Created by Alex Thompson on 6/6/20.
//  Copyright © 2020 Christian Lorenzo. All rights reserved.
//

#import "FetchPhotoOperation.h"
#import "Astronomy_Interoperability-Swift.h"

@interface FetchPhotoOperation()

@property BOOL executing;
@property BOOL finished;
@property BOOL asyncronous;

@end

@implementation FetchPhotoOperation

@synthesize executing = _executing;
@synthesize finished = _finished;
@synthesize asynchronous = _asynchronous;

- (instancetype)initWithReference:(Photo *)photo
{
    self = [super init];
    if (self) {
        _photoReference = photo;
        _imageData = nil;
        _asynchronous = YES;
    }
    return self;
}

- (void)start
{
    // Tell observers we are going to change this
    [self willChangeValueForKey:@"isExecuting"];
    self.executing = YES;
    // Let observers know we changed this
    [self didChangeValueForKey:@"isExecuting"];
    
    self.task = [NSURLSession.sharedSession dataTaskWithURL:self.photoReference.imgSrc completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Inside of FetchPhotoOperation with url: %@", self.photoReference.imgSrc);
        if (error) {
            NSLog(@"Error fetching image for photo: %@", self.photoReference);
            [self willChangeValueForKey:@"isFinished"];
            self.finished = YES;
            [self didChangeValueForKey:@"isFinished"];
            return;
        }
        
        self.imageData = data;
        
        [self willChangeValueForKey:@"isFinished"];
        self.finished = YES;
        [self didChangeValueForKey:@"isFinished"];
    }];
    [self.task resume];
}

- (void)cancel
{
    [self willChangeValueForKey:@"isCancelled"];
    [self.task cancel];
    [super cancel];
}

- (BOOL)isAsyncronous
{
    return YES;
}

- (BOOL)isExecuting
{
    return self.executing;
}

- (BOOL)isFinished
{
    return self.finished;
}
@end
