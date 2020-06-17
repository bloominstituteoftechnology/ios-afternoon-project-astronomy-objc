//
//  CMDMarsRoverController.h
//  Astronomy
//
//  Created by Chris Dobek on 6/17/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CMDRover;
@class MarsRoverPhotos;

typedef void(^ManifestCompletionBlock)(CMDRover *_Nullable rover, NSError *_Nullable error);
typedef void(^FetchPhotosCompletionBlock)(MarsRoverPhotos *_Nullable rover, NSError *_Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface CMDMarsRoverController : NSObject


- (void)fetchManifestWithCompletionHandler:(ManifestCompletionBlock)completionBlock;

- (void)fetchPhotosForSol:(int)sol WithCompletionHandler:(FetchPhotosCompletionBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END
