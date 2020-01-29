//
//  JBCache.m
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-28.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import "JBCache.h"


@interface JBCache()

@property (nonnull, nonatomic) NSMutableDictionary *cache;
@property (nonnull, atomic) dispatch_queue_t dispatchQueue;

@end

@implementation JBCache

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cache = [[NSMutableDictionary alloc] init];
        _dispatchQueue = dispatch_queue_create("AstronomyObjC.PhotoCacheQueue",
                                            DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)cacheItem:(id)value forKey:(NSNumber *)key
{
    dispatch_sync(self.dispatchQueue, ^{
        [self.cache setObject:value forKey:key];
    });
}

- (id)itemforKey:(NSNumber *)key
{
    __block id value;
    dispatch_sync(self.dispatchQueue, ^{
        value = [self.cache objectForKey:key];
    });

    return value;
}

- (id)removeItemForKey:(NSNumber *)key
{
    __block id value;
    dispatch_sync(self.dispatchQueue, ^{
        value = [self.cache objectForKey:key];
        [self.cache removeObjectForKey:key];
    });

    return value;
}

- (void)clear
{
    dispatch_sync(self.dispatchQueue, ^{
        [self.cache removeAllObjects];
    });
}

@end
