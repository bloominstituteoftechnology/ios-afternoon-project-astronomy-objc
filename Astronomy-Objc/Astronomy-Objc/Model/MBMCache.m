//
//  MBMCache.m
//  Astronomy-Objc
//
//  Created by Michael on 3/23/20.
//  Copyright © 2020 Michael. All rights reserved.
//

#import "MBMCache.h"

@implementation MBMCache

- (instancetype)init {
    self = [super init];
    if (self) {
        
        _dictionary = [[NSDictionary  alloc] init];
        _imageQueue =  dispatch_queue_create("Image Queue",DISPATCH_QUEUE_SERIAL);
        
    }
    return self;
}
 
- (void)cacheWithValue:(NSObject *)value
                   key:(NSString *)key {
    dispatch_async(self.imageQueue, ^{
        [self.dictionary setValue:value forKey:key];
    });
}

    
- (NSObject *)valueWithKey:(NSString *)key {
    dispatch_sync(self.imageQueue, ^{
        return [self.dictionary valueForKey:key];
        
        
    });
}

@end
