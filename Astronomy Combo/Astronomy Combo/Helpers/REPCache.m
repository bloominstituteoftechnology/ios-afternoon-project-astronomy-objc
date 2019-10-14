//
//  REPCache.m
//  Astronomy Combo
//
//  Created by Michael Redig on 10/14/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

#import "REPCache.h"

@interface REPCache ()

@property (nonatomic) NSCache *cache;

@end

@implementation REPCache

- (instancetype)init {
	if (self = [super init]) {
		_cache = [[NSCache alloc] init];
	}
	return self;
}

- (void)cacheItemWithKey:(NSString *)key item:(NSData *)data {
	if (data) {
		[self.cache setObject:data forKey:key];
	} else {
		[self.cache removeObjectForKey:key];
	}
}

- (NSData *)itemForKey:(NSString *)key {
	return [self.cache objectForKey:key];
}

@end
