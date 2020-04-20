//
//  JLRMarsRoverClient.h
//  Astronomy
//
//  Created by Jesse Ruiz on 12/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MarsRover;
@class MarsPhotoReference;

NS_SWIFT_NAME(MarsRoverClient)
@interface JLRMarsRoverClient : NSObject

@property (nonatomic, readonly) MarsRover *rover;

@property (nonatomic) NSArray<MarsPhotoReference *> *photos;

- (void)fetchPhotos:(double)sol
         completion:(void (^)(NSArray<MarsPhotoReference *> *photo, NSError *error))completion;

@end
