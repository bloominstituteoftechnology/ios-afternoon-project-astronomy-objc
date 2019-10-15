//
//  Cache.m
//  Astronomy-objc
//
//  Created by Bradley Yin on 10/14/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

#import "BYCache.h"

@interface BYCache ()


@property (nonatomic) NSCache *cache;

@end

@implementation BYCache

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cache = [[NSCache alloc] init];
    }
    return self;
}

- (void)cacheValueForKey:(NSString *)key value:(NSData *)value {
    if (value) {
        [self.cache setObject:value forKey:key];
    }
}

- (NSData *)valueForKey:(NSString *)key {
    return [self.cache objectForKey:key];
}

@end
