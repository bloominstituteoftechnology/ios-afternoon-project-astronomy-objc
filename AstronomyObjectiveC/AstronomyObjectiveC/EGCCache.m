//
//  EGCCache.m
//  AstronomyObjectiveC
//
//  Created by Enrique Gongora on 4/21/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

#import "EGCCache.h"

@interface EGCCache ()

@property (nonatomic, strong) NSMutableDictionary *cache;
@property (nonatomic, strong) dispatch_queue_t queue;

@end

@implementation EGCCache

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cache = [NSMutableDictionary dictionary];
        _queue = dispatch_queue_create("com.LambdaSchool.Astronomy.CacheQueue", DISPATCH_QUEUE_SERIAL);
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
