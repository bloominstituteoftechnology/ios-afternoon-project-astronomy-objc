//
//  CARFetchPhotoOperation.m
//  CARAstronomy
//
//  Created by Chad Rutherford on 2/25/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import "CARFetchPhotoOperation.h"
#import "NSURL+NSURL_CARUsingHTTPS.h"

typedef NS_ENUM(NSUInteger, CARFetchPhotoOperationState) {
    CARFetchPhotoOperationReady,
    CARFetchPhotoOperationIsExecuting,
    CARFetchPhotoOperationIsFinished
};

NSString *photoRawValue(CARFetchPhotoOperationState state) {
    switch (state) {
        case CARFetchPhotoOperationReady:
            return @"isReady";
        case CARFetchPhotoOperationIsExecuting:
            return @"isExecuting";
        case CARFetchPhotoOperationIsFinished:
            return @"isFinished";
    }
}

@interface CARFetchPhotoOperation () {
    CARFetchPhotoOperationState _state;
}

@property (atomic) CARFetchPhotoOperationState state;
@property (atomic, nonnull) NSLock *lock;
@property (nonatomic, nullable) NSURLSessionDataTask *dataTask;

@end

@implementation CARFetchPhotoOperation

- (instancetype)initWithSol:(CARMarsSol *)sol {
    self = [super init];
    if (self) {
        _sol = sol;
        _state = CARFetchPhotoOperationReady;
    }
    return self;
}

- (CARFetchPhotoOperationState)state {
    [self.lock lock];
    CARFetchPhotoOperationState result = _state;
    [self.lock unlock];
    return result;
}

- (void)setState:(CARFetchPhotoOperationState)state {
    [self.lock lock];
    CARFetchPhotoOperationState oldState = _state;
    [self willChangeValueForKey:photoRawValue(oldState)];
    [self willChangeValueForKey:photoRawValue(state)];
    _state = state;
    [self didChangeValueForKey:photoRawValue(oldState)];
    [self didChangeValueForKey:photoRawValue(state)];
    [self.lock unlock];
}

- (BOOL) isAsynchronous {
    return YES;
}

- (BOOL) isReady {
    return (self.state == CARFetchPhotoOperationReady);
}

- (BOOL) isExecuting {
    return (self.state == CARFetchPhotoOperationIsExecuting);
}

- (BOOL) isFinished {
    return (self.state == CARFetchPhotoOperationIsFinished);
}

- (void)start {
    self.state = CARFetchPhotoOperationIsExecuting;
    NSURL *url = [[NSURL URLWithString:self.sol.imageURL] urlUsingHTTPS];
    self.dataTask = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (self.isCancelled) {
            self.state = CARFetchPhotoOperationIsFinished;
            return;
        }
        
        if (error) {
            self.state = CARFetchPhotoOperationIsFinished;
            return;
        }
        
        self.image = [UIImage imageWithData:data];
        self.state = CARFetchPhotoOperationIsFinished;
    }];
    [self.dataTask resume];
}

- (void)cancel {
    [self.dataTask cancel];
    [super cancel];
}

@end
