//
//  LSIFetchPhotoOperation.m
//  Astronomy
//
//  Created by David Wright on 6/7/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

#import "LSIFetchPhotoOperation.h"
#import "Astronomy-Swift.h"
#import "LSIErrors.h"

void *KVOContext = &KVOContext;

@interface LSIFetchPhotoOperation ()

// MARK: - Properties

@property (readwrite, getter=isExecuting) BOOL executing;
@property (readwrite, getter=isFinished) BOOL finished;
@property (readwrite, getter=isCancelled) BOOL cancelled;

@property NSURLSessionDataTask *dataTask;

@end


@implementation LSIFetchPhotoOperation

// MARK: - Initializers

- (instancetype)initWithPhotoURL:(NSURL *)photoURL
{
    if (self = [super init]) {
        _photoURL = photoURL;
        self.executing = NO;
        self.cancelled = NO;
        self.finished = NO;
    }
    return self;
}

+ (instancetype)fetchPhotoOperationWithMarsPhotoReference:(LSIMarsPhotoReference *)marsPhotoReference
{
    return [[self alloc] initWithPhotoURL:marsPhotoReference.imageURL];
}

// MARK: - Methods

- (void)start
{
    if (self.isCancelled) {
        self.finished = YES;
        return;
    }
    
    self.executing = YES;
    
    NSURL *URL = self.photoURL.usingHTTPS;
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:URL
                                              completionHandler:^(NSData * _Nullable data,
                                                                  NSURLResponse * _Nullable response,
                                                                  NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching image from url: %@", error);
            return;
        }
        
        if (!data) {
            NSError *error = errorWithMessage(@"Error receiving photo data: %@", LSIDataNilError);
            NSLog(@"%@", error);
            return;
        }
        
        UIImage *image = [UIImage imageWithData:data];
        
        if (!image) {
            NSError *error = errorWithMessage(@"Error converting fetched data into image: %@", LSIDataCorruptError);
            NSLog(@"%@", error);
            return;
        }
        
        self.image = image;
        self.executing = NO;
        self.finished = YES;
    }];
    [task resume];
    self.dataTask = task;
}

- (void)cancel
{
    [self.dataTask cancel];
    self.executing = NO;
    self.cancelled = YES;
    self.finished = YES;
    [super cancel];
}

// MARK: - Custom Getters/Setters

// isAsynchronous

- (BOOL)isAsynchronous
{
    return YES;
}

// executing

@synthesize executing = _executing;

- (BOOL)isExecuting
{
    return _executing;
}

- (void)setExecuting:(BOOL)executing
{
    if (_executing != executing) {
        [self willChangeValueForKey:@"isExecuting"];
        _executing = executing;
        [self didChangeValueForKey:@"isExecuting"];
    }
}

// finished

@synthesize finished = _finished;

- (BOOL)isFinished
{
    return _finished;
}

- (void)setFinished:(BOOL)finished
{
    if (_finished != finished) {
        [self willChangeValueForKey:@"isFinished"];
        _finished = finished;
        [self didChangeValueForKey:@"isFinished"];
    }
}

// cancelled

@synthesize cancelled = _cancelled;

- (BOOL)isCancelled
{
    return _cancelled;
}

- (void)setCancelled:(BOOL)cancelled
{
    if (_cancelled != cancelled) {
        [self willChangeValueForKey:@"isCancelled"];
        _cancelled = cancelled;
        [self didChangeValueForKey:@"isCancelled"];
    }
}

@end
