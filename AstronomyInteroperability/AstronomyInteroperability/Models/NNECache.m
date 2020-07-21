//
//  NNECache.m
//  AstronomyInteroperability
//
//  Created by Nonye on 7/21/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

#import "NNECache.h"

@interface NNECache()

@property NSMutableDictionary *cache;
@property dispatch_queue_t cacheQueue;

@end


@implementation NNECache

- (instancetype)initWithKey:(NSString *)key value:(id)value
{
    if (self = [super init]) {
        self.cache = [[NSMutableDictionary alloc] initWithObjectsAndKeys:value, key, nil];
        self.cacheQueue = dispatch_queue_create("com.astronomy.cacheQueue", NULL);
    }
    return self;
}

- (void)cacheValue:(id)value forKey:(NSString *)key
{
    dispatch_async(self.cacheQueue, ^{
        [self.cache setValue:value forKey:key];
    });
}

- (_Nullable id)valueForKey:(NSString *)key
{
    dispatch_sync(self.cacheQueue, ^{
        _value = [self.cache valueForKey:key];
    });
    return _value;
}

-(void)clear
{
    dispatch_async(self.cacheQueue, ^{
        [self.cache removeAllObjects];
    });
}

@end
