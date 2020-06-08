//
//  NSObject+NSJSONSerialization.h
//  Astronomy-in-OBJC
//
//  Created by Sal B Amer on 6/4/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MarsPhotos;

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (NSJSONSerialization)

- (instancetype)initArrayWithDictionary:(NSDictionary *) dictionary;

@end

NS_ASSUME_NONNULL_END
