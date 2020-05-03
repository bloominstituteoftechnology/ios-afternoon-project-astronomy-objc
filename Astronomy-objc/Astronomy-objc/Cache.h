//
//  Cache.h
//  Astronomy-objc
//
//  Created by Dillon P on 4/30/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Cache : NSObject

@property NSObject *value;

- (_Nullable id)valueForKey:(NSString *)key;
- (void)cacheValue:(id)value forKey:(NSString *)key;
- (void)clear;

- (instancetype)initWithKey:(NSString *)key value:(id)value;

@end

NS_ASSUME_NONNULL_END
