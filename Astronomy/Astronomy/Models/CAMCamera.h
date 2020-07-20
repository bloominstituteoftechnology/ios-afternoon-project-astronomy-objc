//
//  CAMCamera.h
//  Astronomy
//
//  Created by Cody Morley on 7/20/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(Camera)

@interface CAMCamera : NSObject

@property (nonatomic, readonly) int cameraId;
@property (nonatomic, readonly) int roverId;
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *fullName;

- (instancetype)initWithCameraID:(int)cameraId
                         roverId:(int)roverId
                            name:(NSString *)name
                        fullName:(NSString *)fullName;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
