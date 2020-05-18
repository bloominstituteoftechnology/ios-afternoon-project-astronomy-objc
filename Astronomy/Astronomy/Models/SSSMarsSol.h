//
//  SSSMarsSol.h
//  Astronomy
//
//  Created by Shawn Gee on 5/18/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import "SSSCodableObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSSMarsSol : SSSCodableObject

@property (nonatomic, readonly) int solNumber;
@property (nonatomic, readonly) int numPhotos;

@end

NS_ASSUME_NONNULL_END
