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

@end

@implementation FetchPhotoOperation

- (BOOL)isAsynchronous {
    return YES;
}

- (BOOL)isConcurrent {
    return YES;
}

+ (NSSet *)keyPathsForValuesAffectingIsExecuting {
    return [NSSet setWithObject:@"isExecuting"];
}
+ (NSSet *)keyPathsForValuesAffectingIsFinished {
    return [NSSet setWithObject:@"isFinished"];
}

- (instancetype)initWithRoverPhotoReference:(RoverPhoto *)roverPhotoReference {
    if (self = [super init]) {
        _roverPhotoReference = roverPhotoReference;
    }
    return self;
}

- (void)start {
    self.isExecuting = YES;
    NSURL *url = self.roverPhotoReference.photoURL;
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (self.isCancelled) {
            self.isFinished = YES;
            self.isExecuting = NO;
            return;
        }
        
        if (error) {
            NSLog(@"Error in FetchPhotoOperation %@", error);
            return;
        }
        
        if (data) {
            self.roverPhoto = [UIImage imageWithData:data];
        }
        self.isExecuting = NO;
        self.isFinished = YES;
    }];
    
    [task resume];
    self.dataTask = task;
}

- (void)cancel {
    [self.dataTask cancel];
    [super cancel];
}

@end
