//
//  GIPCache.m
//  Astronomy Objc
//
//  Created by Gi Pyo Kim on 12/17/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

#import "GIPCache.h"

@interface GIPCache()

@property NSMutableDictionary *cache;

@end

@implementation GIPCache

- (instancetype)init {
    self = [super init];
    if (self) {
        _cache = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)cacheValue:(id)value key:(id)key {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.cache[key] addObject:value];
    });
}

- (nullable id)valueFor:(id)key {
    return self.cache[key];
}

- (void)clear {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.cache removeAllObjects];
    });
}

@end
