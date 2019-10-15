//
//  FetchPhotoOperation.m
//  Astronomy-objc
//
//  Created by Bradley Yin on 10/15/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

#import "FetchPhotoOperation.h"
#import "BYMarsPhotoReference.h"

@interface FetchPhotoOperation ()

@property BYMarsPhotoReference *photoReference;
@property NSData *imageData;

@property(atomic, assign, readwrite, getter=isExecuting) BOOL executing;
@property(atomic, assign, readwrite, getter=isFinished) BOOL finished;
@property(atomic, assign, readwrite, getter=isCancelled) BOOL cancelled;

- (NSURLSessionDataTask *)loadImageDataTask;

@end

@implementation FetchPhotoOperation

@synthesize executing, finished, cancelled;

- (NSURLSessionDataTask *)loadImageDataTask {
   NSURLComponents *components = [NSURLComponents componentsWithURL:self.photoReference.imageURL resolvingAgainstBaseURL:YES];
    components.scheme = @"https";
    NSURL *securePhotoURL = components.URL;
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:securePhotoURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // Handle the responses (error vs. data)

        // Call the completion block as needed
        // check the errors
        
        if (error) {
            NSLog(@"Error fetching photo: %@", error);
            [self setFinished:YES];
            return;
        }
        if (data) {
            self.imageData = data;
            [self setFinished:YES];
        } else {
            NSLog(@"no data return on load image");
            [self setFinished:YES];
            return;
        }
        
    }];
    return task;
}

+ (BOOL)automaticallyNotifiesObserversForKey {
  return YES;
}

+ (NSSet *)keyPathsForValuesAffectingIsCancelled {
  NSSet *result = [NSSet setWithObject:@"cancelled"];
  return result;
}

+ (NSSet *)keyPathsForValuesAffectingIsExecuting {
  NSSet *result = [NSSet setWithObject:@"executing"];
      return result;
}

 + (NSSet *)keyPathsForValuesAffectingIsFinished {
    NSSet *result = [NSSet setWithObject:@"finished"];
   return result;
 }




- (void)start {
  //You can use self.executing = YES; (note we can change executing which would otherwise be read-only because we synthesized our own ivar.
    [self setExecuting:YES];
    [[self loadImageDataTask] resume];
}

- (void)cancel {
    [self setCancelled:YES];
    [[self loadImageDataTask] cancel];
}


- (instancetype)initWithPhotoReference:(BYMarsPhotoReference *)photoReference {
    if (self = [super init]) {
        _photoReference = photoReference;
    }
    return self;
}

- (BOOL)isAsynchronous {
    return YES;
}



@end
