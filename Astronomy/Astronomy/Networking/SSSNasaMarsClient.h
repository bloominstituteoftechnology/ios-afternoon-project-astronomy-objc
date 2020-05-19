//
//  SSSNasaMarsClient.h
//  Astronomy
//
//  Created by Shawn Gee on 5/18/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SSSPhotoManifest;
@class SSSMarsSol;
@class SSSMarsPhoto;

typedef void (^SSSFetchManifestCompletion)(SSSPhotoManifest * _Nullable manifest, NSError * _Nullable error);
typedef void (^SSSFetchPhotosCompletion)(NSArray<SSSMarsPhoto *> * _Nullable photos, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(NasaMarsClient)
@interface SSSNasaMarsClient : NSObject

- (void)fetchManifestForRoverNamed:(NSString *)roverName
                        completion:(SSSFetchManifestCompletion)completion;
- (void)fetchPhotosForRoverNamed:(NSString *)roverName
                           onSol:(SSSMarsSol *)sol
                      completion:(SSSFetchPhotosCompletion)completion;

@end

NS_ASSUME_NONNULL_END
