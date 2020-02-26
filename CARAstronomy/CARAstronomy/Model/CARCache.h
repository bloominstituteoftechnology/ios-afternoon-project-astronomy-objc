//
//  CARCache.h
//  CARAstronomy
//
//  Created by Chad Rutherford on 2/25/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Cache)
@interface CARCache : NSObject

@property (nonnull, nonatomic) NSMutableDictionary *cache;

- (void)cacheItem:(id)value forKey:(NSNumber *)key;
- (id _Nullable)itemForKey:(NSNumber *)key;
- (id _Nullable)removeItemForKey:(NSNumber *)key;
- (void)clear;

@end

NS_ASSUME_NONNULL_END
