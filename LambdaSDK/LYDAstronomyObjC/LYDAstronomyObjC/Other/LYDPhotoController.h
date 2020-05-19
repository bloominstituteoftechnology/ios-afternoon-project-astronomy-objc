//
//  LYDPhotoController.h
//  LYDAstronomyObjC
//
//  Created by Lydia Zhang on 5/18/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>


@class LYDRover;
@class LYDPhoto;
typedef void(^completion)(NSArray<NSObject *> *_Nullable);

NS_SWIFT_NAME(PhotosController)

@interface LYDPhotoController : NSObject

NS_ASSUME_NONNULL_BEGIN

@property NSArray<LYDPhoto *> *photoArray;

- (NSURL *)manifestFromRoverURL:(NSString *)rover;
- (NSURL *)photosFromRoverURL:(NSString *)rover sol:(NSNumber *)sol;
- (void)fetchManifestFromRover:(NSString *)rover completion:(completion)completion;
- (void)fetchPhotosFromRover:(NSString *)rover sol:(NSNumber *)sol completion:(completion)completion;

NS_ASSUME_NONNULL_END

@end


