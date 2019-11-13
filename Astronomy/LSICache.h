//
//  LSICache.h
//  Astronomy
//
//  Created by Andrew R Madsen on 11/28/18.
//  Copyright © 2018 Lambda School. All rights reserved.
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
