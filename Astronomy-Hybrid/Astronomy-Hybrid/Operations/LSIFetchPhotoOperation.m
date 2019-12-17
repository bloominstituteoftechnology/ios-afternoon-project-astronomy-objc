//
//  LSIFetchPhotoOperation.m
//  Astronomy-Hybrid
//
//  Created by Isaac Lyons on 12/17/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

#import "LSIFetchPhotoOperation.h"
#import "Astronomy_Hybrid-Swift.h"

@interface LSIFetchPhotoOperation ()

@property (nonatomic, copy, nullable) NSData* imageData;

@property (nonatomic, readwrite) MarsPhotoReference *photoReference;
@property (nonatomic, readwrite) NSURLSessionDataTask *task;

@end

@implementation LSIFetchPhotoOperation

- (instancetype)initWithPhotoReference:(MarsPhotoReference *)photoReference {
    self = [super init];
    if (self) {
        _photoReference = photoReference;
    }
    return self;
}

- (BOOL)isAsynchronous {
    return YES;
}

- (void)start {
    self.task = [[NSURLSession sharedSession] dataTaskWithURL:[self.photoReference imageURL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
            return;
        }
        
        if (data) {
            self.imageData = data;
        }
        
        
    }];
    
    [self.task resume];
}

- (void)cancel {
    [self.task cancel];
}

@end
