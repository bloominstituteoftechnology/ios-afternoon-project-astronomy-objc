//
//  JBCache.m
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-28.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import "JBCache.h"


@interface JBCache()

@property (nonnull, atomic) NSMutableDictionary *cache;
@property (nonnull) NSLock *lock;

@end

@implementation JBCache

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cache = [[NSMutableDictionary alloc] init];
        _lock = [[NSLock alloc] init];
    }
    return self;
}

- (BOOL)didCacheItem:(id)value forKey:(NSNumber *)key
{
    [self.lock lock];
    [self.cache setObject:value forKey:key];
    [self.lock unlock];

    return YES;
}

- (id)itemforKey:(NSNumber *)key
{
    [self.lock lock];
    id value = [self.cache objectForKey:key];
    [self.lock unlock];

    return value;
}

- (id)removeItemForKey:(NSNumber *)key
{
    [self.lock lock];
    id value = [self.cache objectForKey:key];
    [self.cache removeObjectForKey:key];
    [self.lock unlock];

    return value;
}

- (BOOL)didClear
{
    [self.lock lock];
    [self.cache removeAllObjects];
    [self.lock unlock];
    return YES;
}

@end
