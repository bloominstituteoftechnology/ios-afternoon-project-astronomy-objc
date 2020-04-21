//
//  NPTCache.h
//  AstronomyObjC
//
//  Created by Nick Nguyen on 4/21/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Cache)
@interface NPTCache : NSObject

@property (nonnull, nonatomic) NSMutableDictionary *cache;

- (void)cacheItem:(id)value forKey:(NSNumber *)key;
- (id _Nullable)itemForKey:(NSNumber *)key;
- (id _Nullable)removeItemForKey:(NSNumber *)key;
- (void)clear;

@end

NS_ASSUME_NONNULL_END
