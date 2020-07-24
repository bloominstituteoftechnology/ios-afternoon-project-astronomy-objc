//
//  MarsRoverApiController.h
//  AstronomyOBJC
//
//  Created by Kelson Hartle on 7/23/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MarsRover;

NS_ASSUME_NONNULL_BEGIN

// TODO: Uncomment this to work with model created.
//typedef void (^LSIPhotoFetcherCompletion)(NSArray<LSIMarsPhoto *> * _Nullable photos, NSError * _Nullable error);

@interface MarsRoverApiController : NSObject

@property (nonatomic, readonly) MarsRover *marsRover;




@end

NS_ASSUME_NONNULL_END
