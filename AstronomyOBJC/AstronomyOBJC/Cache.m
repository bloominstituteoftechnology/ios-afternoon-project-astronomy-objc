//
//  Cache.m
//  AstronomyOBJc
//
//  Created by Kelson Hartle on 7/30/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import "Cache.h"

@interface Cache ()

@property NSMutableDictionary *dictionary;

@end

@implementation Cache

- (instancetype)init {
    self = [super init];
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)cacheValue:(id)value forKey:(id)key {
    self.dictionary[key] = value;
    
}


- (id)valueForKey:(id)key {
    return self.dictionary[key];
}






@end
