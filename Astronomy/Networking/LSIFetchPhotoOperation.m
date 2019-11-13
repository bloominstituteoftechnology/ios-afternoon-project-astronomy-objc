//
//  LSIFetchPhotoOperation.m
//  Astronomy
//
//  Created by Andrew R Madsen on 11/28/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import "LSIFetchPhotoOperation.h"
#import "LSIMarsPhoto.h"
#import "Astronomy-Swift.h"

@interface LSIFetchPhotoOperation ()

@property (nonatomic, strong, readwrite, nullable) UIImage *image;

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

// Provides -isExecuting and -isFinished KVO compliant methods as required for concurrent NSOperation subclasses
@property BOOL internalIsExecuting;
@property BOOL internalIsFinished;

@end

@implementation LSIFetchPhotoOperation
{
    BOOL _isFinished;
    BOOL _isExecuting;
}

- (BOOL)isAsynchronous { return YES; }

- (instancetype)initWithPhotoReference:(LSIMarsPhoto *)photoReference
{
    self = [super init];
    if (self) {
        _photoReference = photoReference;
    }
    return self;
}

- (void)start
{
    self.internalIsExecuting = YES;

    NSURL *url = self.photoReference.imageURL.usingHTTPS;

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (self.isCancelled) {
            self.internalIsFinished = YES;
            self.internalIsExecuting = NO;
            return;
        }
        if (error) {
            NSLog(@"Error fetching data for %@: %@", self.photoReference, error);
        }

        if (data) {
            self.image = [UIImage imageWithData:data];
        }

        self.internalIsExecuting = NO;
        self.internalIsFinished = YES;
    }];
    [task resume];
    self.dataTask = task;
}

- (void)cancel
{
    [self.dataTask cancel];
    [super cancel];
}

// MARK: - Properties

- (BOOL)isConcurrent { return YES; /* We're doing work on other threads */ }

+ (NSSet *)keyPathsForValuesAffectingIsExecuting { return [NSSet setWithObject:@"internalIsExecuting"]; }
- (BOOL)isExecuting { return self.internalIsExecuting; }
+ (NSSet *)keyPathsForValuesAffectingIsFinished { return [NSSet setWithObject:@"internalIsFinished"]; }
- (BOOL)isFinished { return self.internalIsFinished; }

@end
