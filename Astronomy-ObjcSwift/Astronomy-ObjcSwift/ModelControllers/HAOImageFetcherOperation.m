//
//  HAOImageFetcherOperation.m
//  Astronomy-ObjcSwift
//
//  Created by Hunter Oppel on 6/16/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

#import "HAOImageFetcherOperation.h"
#import "HAOImageFetcher.h"

@interface HAOImageFetcherOperation ()

@property (nonatomic) BOOL internalIsReady;
@property (nonatomic) BOOL internalIsExecuting;
@property (nonatomic) BOOL internalIsFinished;

@property (nonatomic) HAOImageFetcher *imageFetcher;

@end

@implementation HAOImageFetcherOperation

- (instancetype)initWithURL:(NSURL *)URL
{
    self = [super init];
    if (self) {
        _internalIsReady = YES;
        _internalIsExecuting = NO;
        _internalIsFinished = NO;
        _imageFetcher = [[HAOImageFetcher alloc] init];
        
        _URL = URL;
    }
    return self;
}

- (void)start
{
    self.internalIsReady = NO;
    self.internalIsExecuting = YES;
    self.internalIsFinished = NO;
    
    [self.imageFetcher fetchImageFromURL:self.URL completion:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {
            self.internalIsExecuting = NO;
            self.internalIsFinished = YES;
            return;
        }
        
        if (data == nil) {
            self.internalIsExecuting = NO;
            self.internalIsFinished = YES;
            return;
        }
        
        self.imageData = data;
        self.internalIsExecuting = NO;
        self.internalIsFinished = YES;
    }];
    
    self.internalIsReady = YES;
    self.internalIsFinished = NO;
}

- (BOOL)isReady
{
    return self.internalIsReady;
}

- (BOOL)isExecuting
{
    return self.internalIsExecuting;
}

- (BOOL)isFinished
{
    return self.internalIsFinished;
}

- (void)setInternalIsReady:(BOOL)internalIsReady
{
    [self willChangeValueForKey:@"isReady"];
    _internalIsReady = internalIsReady;
    [self didChangeValueForKey:@"isReady"];
}

- (void)setInternalIsExecuting:(BOOL)internalIsExecuting
{
    [self willChangeValueForKey:@"isExecuting"];
    _internalIsExecuting = internalIsExecuting;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)setInternalIsFinished:(BOOL)internalIsFinished
{
    [self willChangeValueForKey:@"isFinished"];
    _internalIsFinished = internalIsFinished;
    [self didChangeValueForKey:@"isFinished"];
}

- (BOOL)isAsynchronous
{
    return YES;
}

@end
