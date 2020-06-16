//
//  Cache.h
//  Obj-C-Astronomy
//
//  Created by Patrick Millet on 6/16/20.
//  Copyright © 2020 PatrickMillet79. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PDMCache : NSObject

@property NSObject *value;

- (_Nullable id)valueForKey:(NSString *)key;
- (void)cacheValue:(id)value forKey:(NSString *)key;
- (void)clear;

- (instancetype)initWithKey:(NSString *)key value:(id)value;

@end

NS_ASSUME_NONNULL_END
