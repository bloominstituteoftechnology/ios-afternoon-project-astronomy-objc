//
//  NSObject+NSJSONSerialization.h
//  AstronomyObjC
//
//  Created by Christopher Devito on 5/18/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TMCMarsPhotoReference;

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (NSJSONSerialization)

- (instancetype)initArrayWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
