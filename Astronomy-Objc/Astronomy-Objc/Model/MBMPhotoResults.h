//
//  MBMPhotoResults.h
//  Astronomy-Objc
//
//  Created by Michael on 3/23/20.
//  Copyright © 2020 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBMPhoto;

NS_ASSUME_NONNULL_BEGIN

@interface MBMPhotoResults : NSObject

@property (nonatomic, readonly, copy) NSArray<MBMPhoto *> *photos;

- (instancetype)initWithPhotos:(NSArray<MBMPhoto *> *)photos;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
