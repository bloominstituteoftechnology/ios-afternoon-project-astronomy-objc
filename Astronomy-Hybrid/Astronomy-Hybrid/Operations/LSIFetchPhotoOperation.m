//
//  LSIFetchPhotoOperation.m
//  Astronomy-Hybrid
//
//  Created by Isaac Lyons on 12/17/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

#import "LSIFetchPhotoOperation.h"
#import "Astronomy_Hybrid-Swift.h"
#import "NSURL+LSISecure.h"

@interface LSIFetchPhotoOperation ()

@property (nonatomic, copy, nullable) NSData* imageData;

@property (nonatomic, readwrite) MarsPhotoReference *photoReference;
@property (nonatomic, readwrite) NSURLSessionDataTask *task;

typedef NS_ENUM(int, State) {isReady, isExecuting, isFinished};
@property State state;

@end

@implementation LSIFetchPhotoOperation

- (instancetype)initWithPhotoReference:(MarsPhotoReference *)photoReference {
    self = [super init];
    if (self) {
        _photoReference = photoReference;
        self.state = isReady;
    }
    return self;
}

- (BOOL)isAsynchronous {
    return YES;
}

- (void)start {
    self.state = isExecuting;
    
    self.task = [[NSURLSession sharedSession] dataTaskWithURL:[[self.photoReference imageURL] usingHTTPS] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
            return;
        }
        
        if (data) {
            self.imageData = data;
        }
        
        self.state = isFinished;
    }];
    
    [self.task resume];
}

- (void)cancel {
    [self.task cancel];
}

- (BOOL)isReady {
    return self.state == isReady;
}

- (BOOL)isExecuting {
    return self.state == isExecuting;
}

- (BOOL)isFinished {
    return self.state == isFinished;
}

+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
    
    if ([key isEqualToString:@"isReady"] || [key isEqualToString:@"isExecuting"] || [key isEqualToString:@"isFinished"]) {
        keyPaths = [keyPaths setByAddingObject:@"state"];
    }
    
    return keyPaths;
}

@end
