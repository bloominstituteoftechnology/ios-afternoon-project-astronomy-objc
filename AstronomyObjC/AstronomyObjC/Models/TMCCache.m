//
//  TMCCache.m
//  AstronomyObjC
//
//  Created by Lydia Zhang on 5/19/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import "TMCCache.h"

@interface TMCCache();

@property (nonatomic, readonly) dispatch_queue_t cacheQueue;
@property (nonatomic) NSMutableDictionary *cacheMutableDic;

@end


@implementation TMCCache

- (instancetype)init {
    self = [super init];
    if (self){
        _cacheQueue = dispatch_queue_create("CacheQueue", NULL);
        _cacheMutableDic = [[NSMutableDictionary alloc]init];
    }
    return self;
}
- (void)cache:(id)object forKey:(id)key{
    dispatch_async(self.cacheQueue, ^{
        self.cacheMutableDic[key] = object;
    });
}

- (id)ObjectByKey:(id)key{
    return self.cacheMutableDic[key];
}

@end
