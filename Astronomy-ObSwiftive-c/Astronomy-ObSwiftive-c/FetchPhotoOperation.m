//
//  ConcurrentOperation.m
//  Astronomy-ObSwiftive-c
//
//  Created by Craig Swanson on 4/27/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import "FetchPhotoOperation.h"
#import "Astronomy_ObSwiftive_c-Swift.h"
#import "RoverPhoto.h"

@interface FetchPhotoOperation ()

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property BOOL internalIsExecuting;
@property BOOL internalIsFinished;

@end

@implementation FetchPhotoOperation

- (BOOL)isAsynchronous {
    return YES;
}

- (BOOL)isConcurrent {
    return YES;
}

- (BOOL)isExecuting {
    return self.internalIsExecuting;
}

- (BOOL)isFinished {
    return self.internalIsFinished;
}

+ (NSSet *)keyPathsForValuesAffectingIsExecuting {
    return [NSSet setWithObject:@"internalIsExecuting"];
}
+ (NSSet *)keyPathsForValuesAffectingIsFinished {
    return [NSSet setWithObject:@"internalIsFinished"];
}

- (instancetype)initWithRoverPhotoReference:(RoverPhoto *)roverPhotoReference {
    if (self = [super init]) {
        _roverPhotoReference = roverPhotoReference;
    }
    return self;
}

- (void)start {
    self.internalIsExecuting = YES;
    NSURL *url = [[NSURL alloc] init];
    url = self.roverPhotoReference.photoURL;
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (self.isCancelled) {
            self.internalIsFinished = YES;
            self.internalIsExecuting = NO;
            return;
        }
        
        if (error) {
            NSLog(@"Error in FetchPhotoOperation %@", error);
            return;
        }
        
        if (data) {
            self.roverPhoto = [UIImage imageWithData:data];
        }
        self.internalIsExecuting = NO;
        self.internalIsFinished = YES;
    }];
    
    [task resume];
    self.dataTask = task;
}

- (void)cancel {
    [self.dataTask cancel];
    [super cancel];
}

@end
