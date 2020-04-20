//
//  VVSCache.h
//  Astronomy-Hybrid
//
//  Created by Vici Shaweddy on 2/16/20.
//  Copyright © 2020 Vici Shaweddy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Cache)
@interface VVSCache<Key, Value> : NSObject

- (void)cache:(Value)object forKey:(Key)key;

- (_Nullable Value)getObjectForKey:(Key)key;

- (void)clear;

@end

NS_ASSUME_NONNULL_END
