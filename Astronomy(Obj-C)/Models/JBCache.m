//
//  JBCache.m
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-28.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import "JBCache.h"


static NSTimeInterval waitTime = 10;


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
    if ([self.lock lockBeforeDate:[NSDate dateWithTimeIntervalSinceNow:waitTime]]) {
        [self.cache setObject:value forKey:[NSString stringWithFormat:@"%@", key]];
        return YES;
    } else { return NO; }
}

- (id)itemforKey:(NSNumber *)key
{
    if ([self.lock lockBeforeDate:[NSDate dateWithTimeIntervalSinceNow:waitTime]]) {
        return [self.cache objectForKey:[NSString stringWithFormat:@"%@", key]];
    } else { return nil; }
}

- (id)removeItemForKey:(NSNumber *)key
{
    if ([self.lock lockBeforeDate:[NSDate dateWithTimeIntervalSinceNow:waitTime]]) {
        id value = [self.cache objectForKey:[NSString stringWithFormat:@"%@", key]];
        [self.cache removeObjectForKey:[NSString stringWithFormat:@"%@", key]];
        return value;
    } else { return nil; }
}

- (BOOL)didClear
{
    if ([self.lock lockBeforeDate:[NSDate dateWithTimeIntervalSinceNow:waitTime]]) {
        [self.cache removeAllObjects];
        return YES;
    } else { return NO; }
}

@end
