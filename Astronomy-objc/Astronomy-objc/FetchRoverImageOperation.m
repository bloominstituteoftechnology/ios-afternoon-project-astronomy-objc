//
//  FetchRoverImageOperation.m
//  Astronomy-objc
//
//  Created by Dillon P on 4/29/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

#import "FetchRoverImageOperation.h"
#import "MarsRoverController.h"

@interface FetchRoverImageOperation ()

// isExecuting and isFinshed properties - these ARE atomic BOOL's as they will be accessed on different threads
@property BOOL internalIsExecuting;
@property BOOL internalIsFinished;
@property BOOL internalIsCancelled;

@property NSURLSessionDataTask *dataTask;
@property NSURLSession *urlSession;
@property (nonatomic, copy) NSString *imgURLString;

@end

@implementation FetchRoverImageOperation

- (instancetype)initWithImageURLString:(NSString *)imageURLString;
{
    if (self = [super init]) {
        self.imgURLString = imageURLString;
        self.urlSession = [NSURLSession sharedSession];
    }
    return self;
}

- (BOOL)isAsynchronous
{
    return YES;
}

- (void)start
{
    if (self.internalIsCancelled) {
        self.internalIsFinished = YES;
        return;
    }
    
    self.internalIsExecuting = YES;
    
    NSURL *url = [[NSURL alloc] initWithString:self.imgURLString];
    
    NSURLSessionDataTask *task = [self.urlSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching image: %@", error);
            self.internalIsExecuting = NO;
            self.internalIsFinished = YES;
            return;
        }
        
        if (!data) {
            NSLog(@"No data returned from data task");
            self.internalIsExecuting = NO;
            self.internalIsFinished = YES;
            return;
        } else {
            self.imgData = data;
            self.internalIsExecuting = NO;
            self.internalIsFinished = YES;
            return;
        }
    }];
    
    [task resume];
    self.dataTask = task;
}


- (void)cancel
{
    if (self.internalIsExecuting) {
        self.internalIsExecuting = NO;
        self.internalIsFinished = YES;
    }
    [self.dataTask cancel];
    self.internalIsCancelled = YES;
}

- (BOOL)isCancelled
{
    return self.internalIsCancelled;
}

- (BOOL)isExecuting
{
    return self.internalIsExecuting;
}


- (BOOL)isFinished
{
    return self.internalIsFinished;
}



+ (NSSet<NSString *> *)keyPathsForValuesAffectingIsExecuting
{
    return [NSSet setWithObject:@"internalIsExecuting"];
}


+ (NSSet<NSString *> *)keyPathsForValuesAffectingIsFinished
{
    return [NSSet setWithObject:@"internalIsFinished"];
}

+ (NSSet<NSString *> *)keyPathsForValuesAffectingInternalIsCancelled
{
    return [NSSet setWithObject:@"internalIsCancelled"];
}



@end
