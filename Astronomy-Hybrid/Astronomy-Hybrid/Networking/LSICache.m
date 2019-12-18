//
//  LSICache.m
//  Astronomy-Hybrid
//
//  Created by Isaac Lyons on 12/17/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

#import "LSICache.h"

@interface LSICache ()

@property NSMutableDictionary *dictionary;

@end

@implementation LSICache

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

//- (void)cacheValue:(id  _Nonnull __autoreleasing *)value forKey:(id  _Nonnull __autoreleasing *)key {
//    self.dictionary[*key] = *value;
//}

- (void)cacheValue:(id)value forKey:(id)key {
    self.dictionary[key] = value;
}

- (id)valueForKey:(id)key {
    return self.dictionary[key];
}

@end
