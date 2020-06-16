//
//  HAOPhotoResult.h
//  Astronomy-ObjcSwift
//
//  Created by Hunter Oppel on 6/15/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HAOPhoto;

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(PhotoResult)

@interface HAOPhotoResult : NSObject

@property (nonatomic, readonly, copy) NSArray<HAOPhoto *> *photos;

- (instancetype)initWithPhotos:(NSArray<HAOPhoto *> *)photos;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
