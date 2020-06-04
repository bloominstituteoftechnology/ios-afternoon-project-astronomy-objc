//
//  SKSCache.h
//  Astronomy-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(Cache)

@interface SKSCache<Key, Value> : NSObject

- (void)cacheValue:(id)value key:(id)key;
- (id)value:(id)key;
- (void)clear;

@end
