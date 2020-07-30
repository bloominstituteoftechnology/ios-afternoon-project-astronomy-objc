//
//  PhotoFetcherOperation.m
//  AstronomyOBJc
//
//  Created by Kelson Hartle on 7/28/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import "PhotoFetcherOperation.h"
#import "LSIMarsRoverPhotoReference.h"

@interface PhotoFetcherOperation ()

@property (readwrite, getter=isExecuting) BOOL isAsynchronous;
@property (readwrite, getter=isFinished) BOOL internalFinished;
@property (readwrite, getter=isCancelled) BOOL executingInternal;
@property (readwrite, getter=<#method#>)

@property (nonatomic) NSURLSessionDataTask *dataTask;

@end

@implementation PhotoFetcherOperation

- (instancetype)initWithPhotoURL:(NSURL *)photoURL {
    if (self = [super init]) {
        _photoURL = photoURL;
        self.executingInternal = NO;
        self.cancelled = NO:
        
    }
    
    
}

- (void)start {
    self.internalFinished = false; // Sends a KVO notification
    NSLog(@"Start");
    
    NSURLSession *session = [NSURLSession sharedSession];
    //  FIXME: need to figure out how to use https: to make it secure. (url)
    NSString *testString = @"https";
    NSURLComponents *urlComps = [NSURLComponents componentsWithURL:self.marsPhotoReference.imageSource resolvingAgainstBaseURL:TRUE];
    urlComps.scheme = testString;
    NSURL *url = urlComps.URL;
    NSLog(@"PHOTO URL: %@ ⏺ ", url);
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching data for \(self.photoReference): %@", error);
            return;
        }
        if (response) {
            NSLog(@"RESPONSE: %@", response);
        }
        self.imageData = data;
    }];
    [task resume];
    self.dataTask = task;
    
    self.internalFinished = true; // Sends a KVO notification
}

- (BOOL)isFinished {
    return _internalFinished;
}

- (void)setInternalFinished:(BOOL)internalFinished {
    if (internalFinished != _internalFinished) { //prevent unnecessary notifications.
        
        [self willChangeValueForKey:@"internalFinished"];// notify
        _internalFinished = internalFinished;
        [self didChangeValueForKey:@"internalFinished"];// notify
        
    }
}


@synthesize isAsynchronous = _isAsynchronous;

-(void)setIsAsynchronous:(BOOL)isAsynchronous {
    if (_isAsynchronous != isAsynchronous) {
        [self willChangeValueForKey:NSStringFromSelector(@selector(isAsynchronous))];
        _isAsynchronous = YES;
        [self didChangeValueForKey:NSStringFromSelector(@selector(isAsynchronous))];
    }
}

- (BOOL)isExecuting {
    
    return _executingInternal;
}

- (void)setExecutingInternal:(BOOL)executingInternal {
    
    if (executingInternal != _executingInternal) {
        [self willChangeValueForKey:@"executingInternal"];
        _executingInternal = executingInternal;
        [self didChangeValueForKey:@"executingInternal"];
        
    }
}


@end
