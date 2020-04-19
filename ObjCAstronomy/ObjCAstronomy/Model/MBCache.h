//
//  MBCache.h
//  ObjCAstronomy
//
//  Created by Mitchell Budge on 7/23/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBCache<Key, Value> : NSObject

@property dispatch_queue_t queue;
@property NSDictionary *cachedItems;

- (void)cacheValue: (Value _Nullable)value forKey: (Key)key;

- (Value _Nullable)valueForKey: (Key)key;

NS_ASSUME_NONNULL_END
