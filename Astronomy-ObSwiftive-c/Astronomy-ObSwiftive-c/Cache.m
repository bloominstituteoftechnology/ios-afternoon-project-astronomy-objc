//
//  Cache.m
//  Astronomy-ObSwiftive-c
//
//  Created by Craig Swanson on 4/27/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import "Cache.h"

@interface Cache ()

@end

@implementation Cache

- (instancetype)init {
    if (self = [super init]) {
        _cache = [[NSMutableDictionary alloc] init];
        _queue = dispatch_queue_create("com.LambdaSchool.AstronomyOjcC.CacheQueue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)cache:(NSNumber * _Nullable )key forValue:(id _Nullable )value {
    dispatch_async(self.queue, ^{
        [self.cache setObject:value forKey:key];
    });
}
- (id _Nullable)value:(NSNumber * _Nullable)key {
    __block id itemForKey;
    dispatch_async(self.queue, ^{
        itemForKey = [self.cache objectForKey:key];
    });
    return itemForKey;
}

- (id)removeValue:(NSNumber *)key {
    __block id itemForKey;
    dispatch_async(self.queue, ^{
        itemForKey = [self.cache objectForKey:key];
        [self.cache removeObjectForKey:key];
    });
    return itemForKey;
}

- (void)clear {
    dispatch_async(self.queue, ^{
        [self.cache removeAllObjects];
    });
}

@end
