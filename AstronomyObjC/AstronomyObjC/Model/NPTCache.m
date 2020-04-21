//
//  NPTCache.m
//  AstronomyObjC
//
//  Created by Nick Nguyen on 4/21/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

#import "NPTCache.h"

@interface NPTCache ()

@property (nonnull, atomic) dispatch_queue_t dispatchQueue;

@end

@implementation NPTCache

- (instancetype) init {
    self = [super init];
    if (self) {
        _cache = [[NSMutableDictionary alloc] init];
        _dispatchQueue = dispatch_queue_create("NPTAstronomy.PhotoCacheQueue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)cacheItem:(id)value forKey:(NSNumber *)key {
    dispatch_sync(self.dispatchQueue, ^{
        [self.cache setObject:value forKey:key];
    });
}

- (id)itemForKey:(NSNumber *)key {
    __block id value;
    dispatch_sync(self.dispatchQueue, ^{
        value = [self.cache objectForKey:key];
    });
    return value;
}

- (id)removeItemForKey:(NSNumber *)key {
    __block id value;
    dispatch_sync(self.dispatchQueue, ^{
        value = [self.cache objectForKey:key];
        [self.cache removeObjectForKey:key];
    });
    return value;
}

- (void)clear {
    dispatch_sync(self.dispatchQueue, ^{
        [self.cache removeAllObjects];
    });
}

@end
