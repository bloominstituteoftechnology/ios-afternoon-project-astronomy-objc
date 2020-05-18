//
//  SSSMarsPhoto.h
//  Astronomy
//
//  Created by Shawn Gee on 5/18/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import "SSSCodableObject.h"

@class SSSMarsCamera;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(MarsPhoto)
@interface SSSMarsPhoto : SSSCodableObject

@property (nonatomic, readonly, copy) NSString *solNumber;
@property (nonatomic, readonly, copy) NSString *earthDate;
@property (nonatomic, readonly, copy) NSString *imageURLString;
@property (nonatomic, readonly) SSSMarsCamera *camera;

@end

NS_ASSUME_NONNULL_END
