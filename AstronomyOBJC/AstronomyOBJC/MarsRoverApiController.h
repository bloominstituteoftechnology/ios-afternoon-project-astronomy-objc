//
//  MarsRoverApiController.h
//  AstronomyOBJC
//
//  Created by Kelson Hartle on 7/23/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AstronomyOBJC-Swift.h"
#import "LSISolDetails.h"
#import "LSIMarsCamera.h"
#import "LSIMarsPhotoReference.h"

@class MarsRover;
typedef void (^LSIMarsRoverFetcherCompletion)(MarsRover * _Nullable marsRover, NSError * _Nullable error);
typedef void (^LSIMarsRoverPhotosFetcherCompletion)(LSIMarsPhotoReference * _Nullable photo, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

// TODO: Uncomment this to work with model created.
//typedef void (^LSIPhotoFetcherCompletion)(NSArray<LSIMarsPhoto *> * _Nullable photos, NSError * _Nullable error);

@interface MarsRoverApiController : NSObject

@property (nonatomic) MarsRover *marsRover;

- (void)fetchMarsRoverPhotosFromRover:(MarsRover *)rover
completionBlock:(LSIMarsRoverPhotosFetcherCompletion)completion;

- (void)fetchMarsRoverWithRoverName:(NSString *)roverName
                   completionBlock:(LSIMarsRoverFetcherCompletion)completion;


@end

NS_ASSUME_NONNULL_END
