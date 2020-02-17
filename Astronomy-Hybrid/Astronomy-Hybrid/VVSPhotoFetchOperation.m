//
//  VVSPhotoFetchOperation.m
//  Astronomy-Hybrid
//
//  Created by Vici Shaweddy on 2/16/20.
//  Copyright © 2020 Vici Shaweddy. All rights reserved.
//

#import "VVSPhotoFetchOperation.h"

void *KVOContext = &KVOContext;

@interface VVSPhotoFetchOperation ()

@property (nonatomic) BOOL isWorking;
@property (nonatomic, readonly) NSURL *url;
@property (nonatomic) NSURLSessionTask *dataTask;

@end

@implementation VVSPhotoFetchOperation

- (instancetype)initWithURL:(NSURL *)url
{
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

- (void)start
{
    if (self.isWorking) {
        return;
    }
    
    self.isWorking = YES;

    // fetch the photo
    NSURLSessionTask *task = [NSURLSession.sharedSession dataTaskWithURL:self.url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (self.isCancelled) { return; }
        
        if (error != nil) {
            NSLog(@"Error fetching photo");
            return;
        }
        
        self.photo = [[UIImage alloc] initWithData:data];
        self.isWorking = NO;
    }];
    [task resume];
    self.dataTask = task;
}

- (void)cancel
{
    [self.dataTask cancel];
    self.isWorking = NO;
    [super cancel];
}

- (void)setIsWorking:(BOOL)isWorking
{
    if (_isWorking != isWorking) {
        [self willChangeValueForKey:@"executing"];
        [self willChangeValueForKey:@"finished"];
        _isWorking = isWorking;
        [self didChangeValueForKey:@"executing"];
        [self didChangeValueForKey:@"finished"];
    }
}

- (BOOL)isAsynchronous
{
    return YES;
}

- (BOOL)isExecuting
{
    return self.isWorking;
}

- (BOOL)isFinished
{
    return !self.isWorking;
}

@end
