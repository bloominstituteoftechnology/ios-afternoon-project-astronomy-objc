//
//  CLMPhotoResult.h
//  Astronomy
//
//  Created by Claudia Maciel on 8/6/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLMPhoto;

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(PhotoResult)

@interface CLMPhotoResult : NSObject

@property (nonatomic, readonly, copy) NSArray<CLMPhoto *> *photos;

- (instancetype)initWithPhotos:(NSArray<CLMPhoto *> *)photos;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
