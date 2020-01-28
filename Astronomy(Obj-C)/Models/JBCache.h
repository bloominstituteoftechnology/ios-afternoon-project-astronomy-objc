//
//  JBCache.h
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-28.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JBCache : NSObject

- (BOOL)didCacheItem:(id)value forKey:(NSNumber *)key;
- (id _Nullable)itemforKey:(NSNumber *)key;
- (id _Nullable)removeItemForKey:(NSNumber *)key;
- (BOOL)didClear;

@end

NS_ASSUME_NONNULL_END
