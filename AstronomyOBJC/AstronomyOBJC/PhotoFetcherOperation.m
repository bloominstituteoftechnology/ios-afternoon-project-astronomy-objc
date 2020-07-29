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

@property (nonatomic) BOOL isAsynchronous;
@property (nonatomic) BOOL internalFinished;
@property (nonatomic) BOOL executingInternal;

@property (nonatomic) NSURLSessionDataTask *dataTask;

@end

@implementation PhotoFetcherOperation

-(instancetype)initWithMarsPhotoReference:(LSIMarsRoverPhotoReference *)marsPhotoReference
                                  //session:(NSURLSession *)session
                                imageData:(NSData *)imageData;
                                 //dataTask:(NSURLSessionDataTask *)dataTask;
{
    
    self = [super init];
        if (self) {
            _marsPhotoReference = marsPhotoReference;
//            _session = session;
            _imageData = imageData;
            //_dataTask = dataTask;
        }
        return self;
    }

- (void)start {
    self.internalFinished = false; // Sends a KVO notification
    NSLog(@"Start");
    
    NSURLSession *session = [NSURLSession sharedSession];
    //  FIXME: need to figure out how to use https: to make it secure. (url)
    NSString *testString = @"https";
    NSURLComponents *componentScheme = [[NSURLComponents alloc] init];
    componentScheme.scheme = testString;
    NSURL *url = self.marsPhotoReference.imageSource;
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching data for \(self.photoReference): \(error)");
            return;
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
