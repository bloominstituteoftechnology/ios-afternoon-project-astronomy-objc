//
//  KMLFetchPhotoOperation.m
//  Astronomy_ObjectiveC
//
//  Created by Kenny on 6/16/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

#import "KMLFetchPhotoOperation.h"
@import UIKit;

@interface KMLFetchPhotoOperation ()

@property (nonatomic, readonly) NSURLSession *session;
@property (nonatomic, readonly) NSURLSessionDataTask *dataTask;

@property(atomic, assign, readwrite, getter=isExecuting) BOOL executing;
@property(atomic, assign, readwrite, getter=isFinished) BOOL finished;
@property(atomic, assign, readwrite, getter=isCancelled) BOOL cancelled;

@end

@implementation KMLFetchPhotoOperation

@synthesize executing, finished, cancelled;

UIImage *privateImage;

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
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

- (instancetype)initWithPhotoURL:(NSURL *)photoURL session:(NSURLSession *)session
{
    self = [super init];
    if (self) {
        _session = [session copy];
        _photoURL = [photoURL copy];
    }
    return self;
}



- (void)start {
    
    __weak NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:self.photoURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (self.isCancelled) {
            return;
        }

        if (error) {
            NSLog(@"Error fetching photo: %@", error);
            return;
        }

        if (!data) {
            NSLog(@"No data from photo operation");
            return;
        }

        UIImage *image = [UIImage imageWithData:data];
        [self setValue:image forKey:@"privateImage"];
        NSLog(@"%@", self.image);
        [self setFinished:YES];
    }];
    [dataTask resume];
    [self setValue:dataTask forKey:@"dataTask"];

}

- (void)cancel {
    [self.dataTask cancel];
    [super cancel];
}

- (UIImage *)image {
    return privateImage;
}



@end
