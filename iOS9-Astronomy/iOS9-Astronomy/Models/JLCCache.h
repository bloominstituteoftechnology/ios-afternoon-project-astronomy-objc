//
//  JLCCache.h
//  iOS9-Astronomy
//
//  Created by Jake Connerly on 11/12/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Cache)
@interface LSICache<Key, Value> : NSObject

- (void)cacheValue:(Value)value forKey:(Key)key;
- (Value _Nullable)cachedValueForKey:(Key)key;
- (void)clear;
@end

NS_ASSUME_NONNULL_END
