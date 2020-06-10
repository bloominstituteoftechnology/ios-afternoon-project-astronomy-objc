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

// MARK: - Interface

@interface LSIFetchPhotoOperation ()

@property (readwrite, getter=isExecuting) BOOL executing;
@property (readwrite, getter=isFinished) BOOL finished;
@property (readwrite, getter=isCancelled) BOOL cancelled;

@property NSURLSessionDataTask *dataTask;

@end

// MARK: - Implementation

@implementation LSIFetchPhotoOperation

- (instancetype)initWithMarsPhotoReference:(LSIMarsPhotoReference *)marsPhotoReference
{
    if (self = [super init]) {
        _marsPhotoReference = marsPhotoReference;
        self.executing = NO;
        self.cancelled = NO;
        self.finished = NO;
    }
    return self;
}

// MARK: - Methods

- (void)start
{
    if (self.isCancelled) {
        self.finished = YES;
        return;
    }
    
    self.executing = YES;
    
    NSURL *URL = self.marsPhotoReference.imageURL.usingHTTPS;
    
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
            NSLog(@"Error fetching image from url: %@", error);
            return;
        }
        
        self.imageData = data;
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

// TODO: Delete this method if not needed
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == KVOContext) {
        if ([keyPath isEqualToString:@"cancelled"]) {
            [self cancel];
        } else if ([keyPath isEqualToString:@"ready"]) {
            [self start];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

// TODO: Delete this method if not needed
/*
+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key
{
    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
    
    if ([key isEqualToString:@"executing"]) {
        NSArray *affectingKeys = @[@"cancelled", @"firstName"];
        keyPaths = [keyPaths setByAddingObjectsFromArray:affectingKeys];
    } else if ([key isEqualToString:@"cancelled"]) {
        NSArray *affectingKeys = @[@"lastName", @"firstName"];
        keyPaths = [keyPaths setByAddingObjectsFromArray:affectingKeys];
    } else if ([key isEqualToString:@"finished"]) {
        NSArray *affectingKeys = @[@"cancelled", @"firstName"];
        keyPaths = [keyPaths setByAddingObjectsFromArray:affectingKeys];
    }
    
    return keyPaths;
}
*/

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
