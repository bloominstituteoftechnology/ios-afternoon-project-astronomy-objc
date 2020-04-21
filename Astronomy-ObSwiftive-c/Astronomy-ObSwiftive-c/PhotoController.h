//
//  PhotoController.h
//  Astronomy-ObSwiftive-c
//
//  Created by Craig Swanson on 4/20/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PhotoManifest;
@class SolPhoto;
@class RoverPhoto;

@interface PhotoController : NSObject

@property (nonatomic, readonly, nonnull) NSArray<RoverPhoto *> *roverPhotos;

- (void)fetchPhotoManifest:(NSString *_Nonnull)roverName;
- (void)fetchRoverPhotos:(NSString *_Nonnull)roverName :(int)sol;

@end
