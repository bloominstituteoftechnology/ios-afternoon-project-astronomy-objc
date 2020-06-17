//
//  CMDCache.m
//  Astronomy
//
//  Created by Chris Dobek on 6/17/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

#import "CMDCache.h"

@interface CMDCache()

@property NSMutableDictionary *cache;
@property dispatch_queue_t cacheQueue;

@end

@implementation CMDCache

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
