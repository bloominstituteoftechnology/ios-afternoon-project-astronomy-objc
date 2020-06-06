//
//  LSIMarsRoverClient.h
//  Astronomy
//
//  Created by David Wright on 6/3/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSIMarsRover;
@class LSIMarsPhotoReference;

typedef void(^MarsRoverFetcherCompletionHandler)(LSIMarsRover *_Nullable marsRover, NSError *_Nullable error);
typedef void(^PhotosFetcherCompletionHandler)(NSArray<LSIMarsPhotoReference *> *_Nullable photos, NSError *_Nullable error);
typedef void(^PhotoFetcherCompletionHandler)(UIImage *_Nullable photo, NSError *_Nullable error);

NS_SWIFT_NAME(MarsRoverClient)
@interface LSIMarsRoverClient : NSObject

- (void)fetchMarsRoverWithName:(nonnull NSString *)name
//                  usingSession:(nullable NSURLSession *)session
             completionHandler:(nonnull MarsRoverFetcherCompletionHandler)completionHandler;

- (void)fetchPhotosFromMarsRover:(nonnull LSIMarsRover *)marsRover
                           onSol:(int)sol
//                    usingSession:(nullable NSURLSession *)session
               completionHandler:(nonnull PhotosFetcherCompletionHandler)completionHandler;

- (void)fetchPhotoWithURLString:(nonnull NSString *)URLString
                   usingSession:(nullable NSURLSession *)session
              completionHandler:(nonnull PhotoFetcherCompletionHandler)completionHandler;

@end
