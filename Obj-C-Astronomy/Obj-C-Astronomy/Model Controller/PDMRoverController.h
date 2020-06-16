//
//  PDMRoverController.h
//  Obj-C-Astronomy
//
//  Created by Patrick Millet on 6/16/20.
//  Copyright © 2020 PatrickMillet79. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class PDMRover;
@class MarsRoverPhotos;

typedef void(^MissionManifestCompletionHandler)(PDMRover *_Nullable rover, NSError *_Nullable error);
typedef void(^FetchAllPhotosCompletionHandler)(MarsRoverPhotos *_Nullable rover, NSError *_Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface PDMMarsRoverController : NSObject

- (void)fetchMissionManifestWithCompletionHandler:(MissionManifestCompletionHandler)completionHandler;

- (void)fetchAllPhotosForSol:(int)sol WithCompletionHandler:(FetchAllPhotosCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
