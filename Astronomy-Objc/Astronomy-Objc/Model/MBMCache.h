//
//  MBMCache.h
//  Astronomy-Objc
//
//  Created by Michael on 3/23/20.
//  Copyright © 2020 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBMCache<T> : NSObject

@property dispatch_queue_t imageQueue;

@property (nonatomic)NSDictionary *dictionary;

- (void)cacheWithValue:(NSObject *)value
                 key:(NSString *)key;

- (NSObject *)valueWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
