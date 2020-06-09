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

// 1. redeclare a readonly property as readwrite (and synthesize variable)
@property (readwrite, getter=isExecuting) BOOL executing;
@property (readwrite, getter=isCancelled) BOOL cancelled;
@property (readwrite, getter=isFinished) BOOL finished;

@property NSURLSessionDataTask *dataTask;

@end


@implementation LSIFetchPhotoOperation

- (instancetype)initWithMarsPhotoReference:(LSIMarsPhotoReference *)marsPhotoReference
{
    if (self = [super init]) {
        _marsPhotoReference = marsPhotoReference;
        _executing = NO;
        _finished = NO;
    }
    return self;
}

- (void)cancel
{
    [self.dataTask cancel];
    self.finished = YES;
    self.executing = NO;
    [super cancel];
}

- (void)start
{
    if (self.isCancelled) {
        _finished = YES;
        return;
    }
    
    self.executing = YES;
    
    NSURL *URL = self.marsPhotoReference.imageURL.usingHTTPS;
    
    self.dataTask = [NSURLSession.sharedSession dataTaskWithURL:URL
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
    [_dataTask resume];
}



// 2. Synthesize it
@synthesize executing = _executing;
@synthesize cancelled = _cancelled;
@synthesize finished = _finished;

// 3. Make KVO method calls with custom setter
- (void)setExecuting:(BOOL)executing
{
    if (_executing != executing) {
        
        // willSet
        // Cleanup KVO - Remove Observers
//        [_executing removeObserver:self forKeyPath:@"executing" context:KVOContext];
//        [_executing removeObserver:self forKeyPath:@"finished" context:KVOContext];
        
        [self willChangeValueForKey:NSStringFromSelector(@selector(isExecuting))];
        _executing = YES;
        [self didChangeValueForKey:NSStringFromSelector(@selector(isExecuting))];
        
        // didSet
        // Setup KVO - Add Observers
//        [_executing addObserver:self forKeyPath:@"executing" options:0 context:KVOContext];
//        [_executing addObserver:self forKeyPath:@"finished" options:0 context:KVOContext];
    }
}

- (BOOL)isExecuting
{
    return _executing;
}

- (void)setFinished:(BOOL)finished
{
    if (_finished != finished) {
        
        // willSet
        
        [self willChangeValueForKey:NSStringFromSelector(@selector(isFinished))];
        _finished = YES;
        [self didChangeValueForKey:NSStringFromSelector(@selector(isFinished))];
        
        // didSet
        
    }
}

- (BOOL)isFinished
{
    return _finished;
}

- (BOOL)isAsynchronous
{
    return YES;
}







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

@end
