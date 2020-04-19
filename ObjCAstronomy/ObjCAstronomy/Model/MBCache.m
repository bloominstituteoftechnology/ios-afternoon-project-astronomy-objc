//
//  MBCache.m
//  ObjCAstronomy
//
//  Created by Mitchell Budge on 7/23/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

#import "MBCache.h"

@implementation MBCache

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        self.queue = dispatch_queue_create("dev.lotanna.Astronomy.cacheQueue", nil);
        self.cachedItems = [[NSDictionary alloc] init];
    }
    return self;
}

- (id)valueForKey:(id)key {
    return _cachedItems[key];
}

- (void)cacheValue:(id)value forKey:(id)key {
    //    dispatch_async(_queue, ^{
    //    [_cachedItems setObject:value forKey:key];
    //    });
}

@end
