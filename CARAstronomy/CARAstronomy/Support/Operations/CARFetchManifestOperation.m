//
//  CARFetchManifestOperation.m
//  CARAstronomy
//
//  Created by Chad Rutherford on 2/25/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import "CARFetchManifestOperation.h"

typedef NS_ENUM(NSUInteger, CARFetchOperationState) {
    CARFetchOperationReady,
    CARFetchOperationIsExecuting,
    CARFetchOperationIsFinished
};

NSString *manifestRawValue(CARFetchOperationState state) {
    switch (state) {
        case CARFetchOperationReady:
            return @"isReady";
        case CARFetchOperationIsExecuting:
            return @"isExecuting";
        case CARFetchOperationIsFinished:
            return @"isFinished";
    }
}

@interface CARFetchManifestOperation () {
    CARFetchOperationState _state;
}

@property (atomic) CARFetchOperationState state;
@property (atomic, nonnull) NSLock *lock;


@end

@implementation CARFetchManifestOperation

- (instancetype) initWithManifestFetcher:(CARManifestFetcher *)manifestFetcher {
    self = [super init];
    if (self) {
        _manifestFetcher = manifestFetcher;
        _state = CARFetchOperationReady;
    }
    return self;
}

- (CARFetchOperationState)state {
    [self.lock lock];
    CARFetchOperationState result = _state;
    [self.lock unlock];
    return result;
}

- (void)setState:(CARFetchOperationState)state {
    [self.lock lock];
    CARFetchOperationState oldState = _state;
    [self willChangeValueForKey:manifestRawValue(oldState)];
    [self willChangeValueForKey:manifestRawValue(state)];
    _state = state;
    [self didChangeValueForKey:manifestRawValue(oldState)];
    [self didChangeValueForKey:manifestRawValue(state)];
    [self.lock unlock];
}

- (BOOL) isAsynchronous {
    return YES;
}

- (BOOL) isReady {
    return (self.state == CARFetchOperationReady);
}

- (BOOL) isExecuting {
    return (self.state == CARFetchOperationIsExecuting);
}

- (BOOL) isFinished {
    return (self.state == CARFetchOperationIsFinished);
}

- (void)start {
    self.state = CARFetchOperationIsExecuting;
    [self.manifestFetcher fetchManifestForRover:@"curiosity" completion:^(CARMarsMissionManifest * _Nullable manifest, NSError * _Nullable error) {
        if (error) {
            self.state = CARFetchOperationIsFinished;
            return;
        }
        
        self.manifest = manifest;
        self.state = CARFetchOperationIsFinished;
    }];
}

@end
