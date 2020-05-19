//
//  TMCFetchOperations.m
//  AstronomyObjC
//
//  Created by Christopher Devito on 5/19/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import "TMCFetchOperations.h"
#import "TMCMarsPhotoReference.h"
#import "NSURL+TMCUsingHTTPS.h"

@interface TMCFetchOperations();

@property (nonatomic, copy, nullable) NSData* imageData;
@property TMCMarsPhotoReference *photo;
@property (nonatomic, readwrite) NSURLSessionDataTask *task;
typedef NS_ENUM(int, State) {isReady, isExecuting, isFinished};
@property State state;

@end

@implementation TMCFetchOperations
- (instancetype)initWithPhotoReference:(TMCMarsPhotoReference *)photo{
    self = [super init];
    if (self) {
        _photo = photo;
        self.state = isReady;
    }
    return self;
}

- (BOOL)isAsynchronous {
    return YES;
}

- (void)start {
    self.state = isExecuting;
    NSURL *url = self.photo.imageURL.usingHTTPS;
    NSURLSessionTask *task = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error) {
            self.fetchError = error;
            self.state = isFinished;
            return;
        }

        if (!data) {
            self.state = isFinished;
            return;
        }

        self.imageData = data;
        self.state = isFinished;
        return;
    }];
    [task resume];
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
