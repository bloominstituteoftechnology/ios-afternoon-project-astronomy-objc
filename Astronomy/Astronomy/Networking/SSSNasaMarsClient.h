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

NS_ASSUME_NONNULL_BEGIN

@interface SSSNasaMarsClient : NSObject

- (SSSPhotoManifest *)fetchManifestForRoverNamed:(NSString *)roverName;
- (NSArray<SSSMarsPhoto *> *)fetchPhotosForSol:(SSSMarsSol *)sol;

@end

NS_ASSUME_NONNULL_END
