//
//  SKSCache.m
//  Astronomy-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "SKSCache.h"

@interface SKSCache()

@property (nonatomic, nonnull) NSMutableDictionary<id, id> *cache;
@property dispatch_queue_t queue;

@end

@implementation SKSCache

- (instancetype)init
{
    self = [super init];
    if (self) {
        dispatch_queue_attr_t qos = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INITIATED, -1);
        _queue = dispatch_queue_create("CacheQueue", qos);
        _cache = [[NSMutableDictionary<id, id> alloc] init];
    }
    return self;
}

- (void)cacheValue:(id)value key:(id)key {
    dispatch_async(self.queue, ^{
        [self.cache setObject:value forKey:key];
    });
}

- (id)value:(id)key {
    __block id value = nil;
    dispatch_sync(self.queue, ^{
        value = self.cache[key];
    });
    return value;
}

- (void)clear {
    [self.cache removeAllObjects];
}

@end
