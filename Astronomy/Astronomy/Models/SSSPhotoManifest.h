//
//  SSSPhotoManifest.h
//  Astronomy
//
//  Created by Shawn Gee on 5/18/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import "SSSCodableObject.h"

@class SSSMarsSol;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(PhotoManifest)
@interface SSSPhotoManifest : SSSCodableObject

@property (nonatomic, readonly, copy) NSArray<SSSMarsSol *> *sols;

@end

NS_ASSUME_NONNULL_END
