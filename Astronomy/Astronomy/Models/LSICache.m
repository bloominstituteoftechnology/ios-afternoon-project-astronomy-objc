//
//  LSICache.m
//  Astronomy
//
//  Created by David Wright on 6/10/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

#import "LSICache.h"

@interface LSICache ()

@property (copy, readwrite) NSMutableDictionary<NSNumber *, id> *cache;
@property (copy, readonly) dispatch_queue_t queue;

@end


@implementation LSICache

- (instancetype)init
{
    if (self = [super init]) {
        _queue = dispatch_queue_create([@"AstronomyCacheQueue" UTF8String], nil);
    }
    return self;
}

- (void)cacheValue:(id)value ForKey:(NSNumber *)key
{
    dispatch_async(self.queue, ^{
        [self.cache setObject:value forKey:key];
    });
}

- (id)valueForKey:(NSNumber *)key
{
    __block id value;
    dispatch_sync(self.queue, ^{
        value = [self.cache objectForKey:key];
    });
    return value;
}

- (void)clear
{
    dispatch_async(self.queue, ^{
        [self.cache removeAllObjects];
    });
}

@end
