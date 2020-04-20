//
//  UFOAPIController.h
//  Astronomy - ObjC
//
//  Created by Ufuk Türközü on 20.04.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UFOMarsPhoto;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(APIController)
@interface UFOAPIController : NSObject

- (void)fetchPhotoWithSol:(int)sol completion: (void(^)(UFOMarsPhoto *))completion;

@end

NS_ASSUME_NONNULL_END
