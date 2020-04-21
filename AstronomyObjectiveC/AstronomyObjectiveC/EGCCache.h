//
//  EGCCache.h
//  AstronomyObjectiveC
//
//  Created by Enrique Gongora on 4/21/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(Cache)
@interface EGCCache<Key, Value> : NSObject

- (void)cacheValue:(Value)value forKey:(Key)key;
- (Value _Nullable)cachedValueForKey:(Key)key;
- (void)clear;

@end

NS_ASSUME_NONNULL_END
