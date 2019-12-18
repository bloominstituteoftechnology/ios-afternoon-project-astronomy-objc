//
//  LSICache.h
//  Astronomy-Hybrid
//
//  Created by Isaac Lyons on 12/17/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(Cache)
@interface LSICache<Key, Value> : NSObject

- (void)cacheValue:(Value _Nonnull)value
            forKey:(Key _Nonnull)key;

- (nullable Value)valueForKey:(Key _Nonnull)key;

@end
