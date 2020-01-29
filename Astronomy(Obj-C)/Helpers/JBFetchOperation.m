//
//  JBFetchOperation.m
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-28.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import "JBFetchOperation.h"


#pragma mark - State Enum

typedef NS_ENUM(NSUInteger, JBFetchOperationState) {
    JBFetchOperationIsReady,
    JBFetchOperationIsExecuting,
    JBFetchOperationIsFinished
};

NSString *rawValueForState(JBFetchOperationState state)
{
    switch (state)
    {
        case JBFetchOperationIsReady:
            return @"isReady";
        case JBFetchOperationIsExecuting:
            return @"isExecuting";
        case JBFetchOperationIsFinished:
            return @"isFinished";
    }
}


#pragma mark - Setup / Init

@interface JBFetchOperation() {
    JBFetchOperationState _state;
}

@property (atomic) JBFetchOperationState state;
@property (atomic, nonnull) NSLock *stateLock;
@property (nonatomic, nonnull) NSURLRequest *request;
@property (nonatomic, nullable) NSURLSessionDataTask *dataTask;
@property (nonatomic, nullable) NSError *internalError;
@property (nonatomic, nullable) NSData *internalData;

@end


@implementation JBFetchOperation

- (instancetype)initWithRequest:(NSURLRequest *)request
{
    self = [super init];
    if (self) {
        _request = request;
        _state = JBFetchOperationIsReady;
    }
    return self;
}

#pragma mark - Computed Properties

- (NSError *)error
{
    return self.internalError;
}

- (NSData *)data
{
    return self.internalData;
}

- (UIImage *)image
{
    if (self.data) {
        UIImage *image = [UIImage imageWithData:self.data];
        return image;
    } else {
        return nil;
    }
}

#pragma mark - Operation Properties

- (JBFetchOperationState)state
{
    [self.stateLock lock];
    JBFetchOperationState result = _state;
    [self.stateLock unlock];
    return result;
}

- (void)setState:(JBFetchOperationState)state
{
    [self.stateLock lock];
    JBFetchOperationState oldState = _state;
    [self willChangeValueForKey:rawValueForState(oldState)];
    [self willChangeValueForKey:rawValueForState(state)];
    _state = state;
    [self didChangeValueForKey:rawValueForState(oldState)];
    [self didChangeValueForKey:rawValueForState(state)];
    [self.stateLock unlock];
}

- (BOOL)isAsynchronous
{
    return YES;
}

- (BOOL)isReady
{
    return (self.state == JBFetchOperationIsReady);
}

- (BOOL)isExecuting
{
    return (self.state == JBFetchOperationIsExecuting);
}

- (BOOL)isFinished
{
    return (self.state == JBFetchOperationIsFinished);
}

#pragma mark - Operation Methods

- (void)start
{
    self.state = JBFetchOperationIsExecuting;
    self.dataTask = [NSURLSession.sharedSession
                     dataTaskWithRequest:self.request
                     completionHandler:^(NSData * _Nullable data,
                                         NSURLResponse * _Nullable response,
                                         NSError * _Nullable error)
    {
        if (self.isCancelled) {
            self.state = JBFetchOperationIsFinished;
            return;
        }
        if (error) {
            self.internalError = error;
            self.state = JBFetchOperationIsFinished;
            return;
        }
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse && (httpResponse.statusCode < 200 || httpResponse.statusCode > 299)) {
            NSLog(@"Bad response %li for photo fetch", httpResponse.statusCode);
            self.state = JBFetchOperationIsFinished;
            return;
        }
        self.internalData = data;
        self.state = JBFetchOperationIsFinished;
    }];
    [self.dataTask resume];
}

- (void)cancel
{
    [self.dataTask cancel];
    [super cancel];
}

@end
