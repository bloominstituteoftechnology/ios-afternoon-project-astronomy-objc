//
//  MarsPhotoReference.h
//  Astronomy-objc
//
//  Created by Matthew Martindale on 8/5/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MarsPhotoReference : NSObject

@property (nonatomic, readonly) int *photoId;
@property (nonatomic, readonly, copy)NSString *imageURLString;

- (instancetype)initWithId:(int)photoId
            imageURLString:(NSString *)imageURLString;

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
