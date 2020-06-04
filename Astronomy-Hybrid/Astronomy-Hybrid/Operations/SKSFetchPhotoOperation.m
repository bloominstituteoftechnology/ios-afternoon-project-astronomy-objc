//
//  SKSFetchPhotoOperation.m
//  Astronomy-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "SKSFetchPhotoOperation.h"
#import "SKSPhotoReference.h"
#import "NSURL+SKSSecure.h"

@interface SKSFetchPhotoOperation()

@property (nonatomic, nonnull) SKSPhotoReference *photoReference;
@property (nonatomic, nullable) NSURLSessionDataTask *dataTask;

@property BOOL opIsExecuting;
@property BOOL opIsFinished;

@end

@implementation SKSFetchPhotoOperation
{
    BOOL _isExecuting;
    BOOL _isFinished;
}

- (instancetype)initWithPhotoReference:(SKSPhotoReference *)photoReference {
    self = [super init];
    if (self) {
        _photoReference = photoReference;
    }
    return self;
}

- (void)start {

    // set state to isExecuting

    self.opIsExecuting = YES;

    // TODO: MAKE SURE TO CHANGE TO HTTPS!
    NSLog(@"URL: %@", self.photoReference.imageURL.usingHTTPS);

    NSURL *imageURL = self.photoReference.imageURL.usingHTTPS;

    _dataTask = [[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (self.isCancelled) { return; }
        if (error) {
            NSLog(@"Error fetching data for photo");
            return;
        }

        if (data) {
            self.imageData = data;
        }
        // set state to finished
        self.opIsExecuting = NO;
        self.opIsFinished = YES;

    }];
    [self.dataTask resume];
}

- (void)cancel {
    [self.dataTask cancel];
    [super cancel];
}

// MARK: NSOperation

+ (NSSet *)keyPathsForValuesAffectingisFinished {
    return [NSSet setWithObjects:@"opIsFinished", nil];
}

- (BOOL)isFinished {
    return self.opIsFinished;
}

+ (NSSet *)keyPathsForValuesAffectingIsExecuting {
    return [NSSet setWithObjects:@"opIsExecuting", nil];
}

- (BOOL)isExecuting {
    return self.opIsExecuting;
}

- (BOOL)isReady {
    return [super isReady];
}

- (BOOL)isAsynchronous {
    return YES;
}

@end
