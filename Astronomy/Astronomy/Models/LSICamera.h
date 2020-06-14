//
//  LSICamera.h
//  Astronomy
//
//  Created by David Wright on 6/3/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(Camera)
@interface LSICamera : NSObject

@property (nonatomic, readonly) int cameraId;
@property (nonatomic, readonly) int roverId;
@property (nonatomic, copy, readonly, nonnull) NSString *name;
@property (nonatomic, copy, readonly, nonnull) NSString *fullName;

- (nonnull instancetype)initWithCameraId:(int)cameraId
                                 roverId:(int)roverId
                                    name:(nonnull NSString *)name
                                fullName:(nonnull NSString *)fullName;

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end
