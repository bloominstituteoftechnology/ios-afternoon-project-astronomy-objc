//
//  CDGCache.m
//  AstronomyObjC
//
//  Created by Chris Gonzales on 4/23/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

#import "CDGCache.h"

@interface CDGCache()

@property (nonatomic, strong) NSMutableDictionary *cache;
@property (nonatomic, strong) dispatch_queue_t queue;

@end

@implementation CDGCache

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cache = [NSMutableDictionary dictionary];
        _queue = dispatch_queue_create("com.ChristopherGonzales.AstronomyObjC.CacheQueue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)cacheValue:(id)value forKey:(id)key
{
    dispatch_async(self.queue, ^{
        self.cache[key] = value;
    });
}

- (id)cachedValueForKey:(id)key
{
    __block id result = nil;
    dispatch_sync(self.queue, ^{
        result = self.cache[key];
    });
    return result;
}

- (void)clear
{
    dispatch_async(self.queue, ^{
        [self.cache removeAllObjects];
    });
}
@end
