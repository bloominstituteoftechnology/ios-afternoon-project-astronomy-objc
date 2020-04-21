//
//  SAHFetchPhotoOperation.m
//  Astronomy-ObjC
//
//  Created by scott harris on 4/21/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

#import "SAHFetchPhotoOperation.h"

@interface SAHFetchPhotoOperation ()

@property (nonatomic, readonly) NSString *state;

// Provides -isExecuting and -isFinished KVO compliant methods as required for concurrent NSOperation subclasses
@property BOOL internalIsExecuting;
@property BOOL internalIsFinished;

@end

@implementation SAHFetchPhotoOperation
{
    BOOL _isFinished;
    BOOL _isExecuting;
}

- (BOOL)isAsynchronous {
    return YES;
}

- (instancetype)initWithSolPhoto:(SAHSolPhoto *)photo {
    self = [super init];
    if (self) {
        _solPhoto = photo;
    }
    
    return self;
}

- (void)start {
    
    
}

- (void)cancel {
    
}

- (BOOL)isConcurrent { return YES; /* We're doing work on other threads */ }

+ (NSSet *)keyPathsForValuesAffectingIsExecuting { return [NSSet setWithObject:@"internalIsExecuting"]; }
- (BOOL)isExecuting { return self.internalIsExecuting; }
+ (NSSet *)keyPathsForValuesAffectingIsFinished { return [NSSet setWithObject:@"internalIsFinished"]; }
- (BOOL)isFinished { return self.internalIsFinished; }



@end
