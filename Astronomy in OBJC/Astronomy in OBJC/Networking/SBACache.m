//
//  SBACache.m
//  Astronomy-in-OBJC
//
//  Created by Sal B Amer on 6/4/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

#import "SBACache.h"

@interface SBACache();

@property (nonatomic, readonly) dispatch_queue_t cacheQueue;
@property (nonatomic) NSMutableDictionary *cacheMutableDictionary;

@end

@implementation SBACache

- (instancetype)init {
  self = [super init];
  if (self){
    _cacheQueue = dispatch_queue_create("CacheQueue", NULL);
    _cacheMutableDictionary = [[NSMutableDictionary alloc] init];
  }
  return self;
}

- (void)cache:(id)object forKey:(id)key{
  dispatch_async(self.cacheQueue, ^{
    self.cacheMutableDictionary[key] = object;
  });
}

- (id)ObjectByKey:(id)key {
  return self.cacheMutableDictionary[key];
}


@end
