//
//  CDGFetchPhoto.m
//  AstronomyObjC
//
//  Created by Chris Gonzales on 4/21/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

#import "CDGFetchPhoto.h"
#import "CDGPhoto.h"
#import "AstronomyObjC-Swift.h"

@interface CDGFetchPhoto ()

@property (nonatomic, strong, readwrite, nullable) UIImage *image;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@property BOOL internalIsExecuting;
@property BOOL internalIsFinished;

@end

@implementation CDGFetchPhoto { BOOL _isFinished;
BOOL _isExecuting;
}

- (BOOL)isConcurrent { return YES; }
+ (NSSet *)keyPathsForValuesAffectingIsExecuting { return [NSSet setWithObject:@"internalIsExecuting"]; }
- (BOOL)isExecuting { return self.internalIsExecuting; }
+ (NSSet *)keyPathsForValuesAffectingIsFinished { return [NSSet setWithObject:@"internalIsFinished"]; }
- (BOOL)isFinished { return self.internalIsFinished; }
- (BOOL)isAsynchronous { return YES; }

- (instancetype)initWithPhoto:(CDGPhoto *)photo
{
    self = [super init];
    if (self) {
        _photo = photo;
    }
    return self;
}

- (instancetype)initWithPhotoReference:(CDGPhoto *)photo
{
    self = [super init];
    if (self) {
        _photo = photo;
    }
    return self;
}

- (void)start
{
    self.internalIsExecuting = YES;
    
    NSURL *url = self.photo.imageURL.usingHTTPS;
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (self.isCancelled) {
            self.internalIsFinished = YES;
            self.internalIsExecuting = NO;
            return;
        }
        if (error) {
            NSLog(@"Error fetching data for %@: %@", self.photo, error);
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

@end
