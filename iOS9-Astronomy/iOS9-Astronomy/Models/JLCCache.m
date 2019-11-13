//
//  JLCCache.m
//  iOS9-Astronomy
//
//  Created by Jake Connerly on 11/12/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

#import "JLCCache.h"



@interface LSICache ()

@property (nonatomic, strong) NSMutableDictionary *cache;
@property (nonatomic, strong) dispatch_queue_t queue;

@end

@implementation LSICache

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
