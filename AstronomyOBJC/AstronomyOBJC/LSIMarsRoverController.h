//
//  LSIMarsRoverController.h
//  AstronomyOBJc
//
//  Created by Kelson Hartle on 7/25/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MarsRover;
@class LSIMarsRoverPhotoReference;
typedef void (^LSIMarsRoverFetcherCompletion)(MarsRover * _Nullable marsRover, NSError * _Nullable error);
typedef void (^LSIMarsRoverPhotosFetcherCompletion)(LSIMarsRoverPhotoReference * _Nullable photo, NSError * _Nullable error);


NS_ASSUME_NONNULL_BEGIN

@interface LSIMarsRoverController : NSObject

- (void)fetchMarsRoverPhotosFromRover:(NSString *)photoRef onSol:(NSNumber *)sol
completionBlock:(LSIMarsRoverPhotosFetcherCompletion)completion;

- (void)fetchMarsRoverWithRoverName:(NSString *)roverName
                   completionBlock:(LSIMarsRoverFetcherCompletion)completion;

@end

NS_ASSUME_NONNULL_END
