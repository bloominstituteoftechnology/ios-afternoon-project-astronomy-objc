//
//  CMDMarsPhotoController.h
//  Astronomy
//
//  Created by Chris Dobek on 6/15/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MarsPhoto;
@class UIImage;
@class CMDManifest;

NS_ASSUME_NONNULL_BEGIN

@interface CMDMarsPhotoController : NSObject

// MARK: - Properties
@property (nonatomic, readonly) NSMutableArray<MarsPhoto *> *marsPhotos;
@property (nonatomic, readonly) NSMutableArray<CMDManifest *> *manifests;

// MARK: - Methods
- (void)fetchingSinglePhotoWithURL:(NSURL *)imageURL
                   completion:(void(^)(NSError *error, UIImage * image))completion;

- (void)fetchManifest:(void (^)(NSError *error))completion;

- (void)fetchSolByManifest:(CMDManifest *)manifest
completionBlock:(void (^)(NSError *error))completionBlock;



@end

NS_ASSUME_NONNULL_END
