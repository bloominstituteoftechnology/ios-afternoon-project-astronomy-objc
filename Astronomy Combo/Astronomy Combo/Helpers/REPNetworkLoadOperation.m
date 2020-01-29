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

@property (nonatomic) dispatch_queue_t stateQueue;

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
	__block bool value;
	dispatch_sync(self.stateQueue, ^{
		value = [super isReady] && _ready;
	});
	return value;
}

- (BOOL)isExecuting {
	__block bool value;
	dispatch_sync(self.stateQueue, ^{
		value = _executing;
	});
	return value;
}

- (BOOL)isFinished {
	__block bool value;
	dispatch_sync(self.stateQueue, ^{
		value = _finished;
	});
	return value;
}

- (void)setReady:(BOOL)ready {
	[self willChangeValueForKey:@"isReady"];
	dispatch_sync(self.stateQueue, ^{
		_ready = ready;
	});
	[self didChangeValueForKey:@"isReady"];
}

- (void)setExecuting:(BOOL)executing {
	[self willChangeValueForKey:@"isExecuting"];
	dispatch_sync(self.stateQueue, ^{
		_executing = executing;
	});
	[self didChangeValueForKey:@"isExecuting"];
}

- (void)setFinished:(BOOL)finished {
	[self willChangeValueForKey:@"isFinished"];
	dispatch_sync(self.stateQueue, ^{
		_finished = finished;
	});
	[self didChangeValueForKey:@"isFinished"];
}

- (instancetype)initWithURL:(NSURL *)url {
	if (self = [super init]) {
		_internalURL = url;
		_stateQueue = dispatch_queue_create("com.astronomy.combo", DISPATCH_QUEUE_SERIAL);
		dispatch_sync(self.stateQueue, ^{
			_ready = YES;
			_executing = NO;
			_finished = NO;
		});
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
		self.executing = NO;
		self.finished = YES;
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
