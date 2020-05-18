//
//  SSSMarsCamera.h
//  Astronomy
//
//  Created by Shawn Gee on 5/18/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import "SSSCodableObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSSMarsCamera : SSSCodableObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *roverID;

@end

NS_ASSUME_NONNULL_END
