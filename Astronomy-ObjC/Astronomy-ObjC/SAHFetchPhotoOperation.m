//
//  SAHFetchPhotoOperation.m
//  Astronomy-ObjC
//
//  Created by scott harris on 4/21/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

#import "SAHFetchPhotoOperation.h"
#import "SAHSolPhoto.h"

@interface SAHFetchPhotoOperation ()

// Provides -isExecuting and -isFinished KVO compliant methods as required for concurrent NSOperation subclasses
@property BOOL internalIsExecuting;
@property BOOL internalIsFinished;
@property (nonatomic) NSURLSessionDataTask *dataTask;


@end

@implementation SAHFetchPhotoOperation

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
    self.internalIsExecuting = YES;
    
    // DEAL WITH CANCEL HERE
    
    NSURL *url = [[NSURL alloc] initWithString:self.solPhoto.imageUrl];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:NO];
    
    urlComponents.scheme = @"https";
    
    NSURL *finalURL = urlComponents.URL;
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"URL: %@", finalURL);
        
        if (error) {
            NSLog(@"Data task error: %@", error);
            return;
        }
        
        if (!data) {
            NSError *dataError = [[NSError alloc] initWithDomain:@"com.sah.Astronomy" code:100 userInfo:nil];
            NSLog(@"Data was nil");
            return;
        }
        
        self.imageData = [[NSData alloc] initWithData:data];
        self.internalIsExecuting = NO;
        self.internalIsFinished = YES;
        
    }];
    
    [task resume];
 
}

- (void)cancel {
    
}

- (BOOL)isConcurrent { return YES; /* We're doing work on other threads */ }

+ (NSSet *)keyPathsForValuesAffectingIsExecuting { return [NSSet setWithObject:@"internalIsExecuting"]; }
- (BOOL)isExecuting { return self.internalIsExecuting; }
+ (NSSet *)keyPathsForValuesAffectingIsFinished { return [NSSet setWithObject:@"internalIsFinished"]; }
- (BOOL)isFinished { return self.internalIsFinished; }

@end
