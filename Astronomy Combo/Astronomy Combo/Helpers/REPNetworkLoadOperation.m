//
//  REPNetworkLoadOperation.m
//  Astronomy Combo
//
//  Created by Michael Redig on 10/15/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

#import "REPNetworkLoadOperation.h"

@interface REPNetworkLoadOperation()

@property (nonatomic) NSURL *internalURL;
@property (nonatomic) NSURLSessionDataTask *dataTask;
@property (nonatomic) NSData *internalLoadedData;
@property (nonatomic, getter = isReady) BOOL ready;
@property (nonatomic, getter = isExecuting) BOOL executing;
@property (nonatomic, getter = isFinished) BOOL finished;

@end

@implementation REPNetworkLoadOperation
@synthesize ready = _ready;
@synthesize executing = _executing;
@synthesize finished = _finished;

- (BOOL)isAsynchronous {
	return YES;
}

- (NSURL *)url {
	return self.internalURL;
}

- (NSData *)loadedData {
	return self.internalLoadedData;
}

- (BOOL)isReady {
	return [super isReady] && _ready;
}

- (BOOL)isExecuting {
	return _executing;
}

- (BOOL)isFinished {
	return _finished;
}

- (void)setReady:(BOOL)ready {
	[self willChangeValueForKey:@"isReady"];
	_ready = ready;
	[self didChangeValueForKey:@"isReady"];
}

- (void)setExecuting:(BOOL)executing {
	[self willChangeValueForKey:@"isExecuting"];
	_executing = executing;
	[self didChangeValueForKey:@"isExecuting"];
}

- (void)setFinished:(BOOL)finished {
	[self willChangeValueForKey:@"isFinished"];
	_finished = finished;
	[self didChangeValueForKey:@"isFinished"];
}

- (instancetype)initWithURL:(NSURL *)url {
	if (self = [super init]) {
		_internalURL = url;
		_ready = YES;
		_executing = NO;
		_finished = NO;
	}
	return self;
}

- (void)start {
	self.ready = NO;
	self.executing = YES;

	self.dataTask = [[NSURLSession sharedSession] dataTaskWithURL:self.url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
		if (self.isCancelled) {
			self.executing = NO;
			self.finished = YES;
			return;
		}

		if (error) {
			NSLog(@"Error loading %@: %@", self.url, error);
			self.executing = NO;
			self.finished = YES;
			return;
		}

		self.internalLoadedData = data;
	}];
	[self.dataTask resume];
}

- (void)cancel {
	if (self.dataTask) {
		[self.dataTask cancel];
	}
	[super cancel];
}


@end
