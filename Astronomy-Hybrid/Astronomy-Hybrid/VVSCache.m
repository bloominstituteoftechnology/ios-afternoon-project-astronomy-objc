//
//  VVSCache.m
//  Astronomy-Hybrid
//
//  Created by Vici Shaweddy on 2/16/20.
//  Copyright © 2020 Vici Shaweddy. All rights reserved.
//

#import "VVSCache.h"

@interface VVSCache ()

@property (nonatomic, readonly) dispatch_queue_t queue;
@property (nonatomic) NSMutableDictionary *cache;

@end

@implementation VVSCache

- (instancetype)init
{
    if (self = [super init]) {
        _queue = dispatch_queue_create("com.LambdaSchool.Astronomy.CacheQueue", NULL);
        _cache = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)cache:(id)object forKey:(NSString *)key
{
    dispatch_async(self.queue, ^{
        self.cache[key] = object;
    });
}

- (_Nullable id)getObjectForKey:(NSString *)key
{
    __block id tmpObject = nil;
    dispatch_sync(self.queue, ^{
        tmpObject = self.cache[key];
    });
    return tmpObject;
}

- (void)clear
{
    dispatch_async(self.queue, ^{
        [self.cache removeAllObjects];
    });
}

@end
