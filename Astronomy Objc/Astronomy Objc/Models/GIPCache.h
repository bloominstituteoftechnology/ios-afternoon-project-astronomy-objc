//
//  GIPCache.h
//  Astronomy Objc
//
//  Created by Gi Pyo Kim on 12/17/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(Cache)

@interface GIPCache<Key, Value> : NSObject

- (void)cacheValue:(nonnull Value)value key:(nonnull Key)key;
- (nullable Value)valueFor:(nonnull Key)key;
- (void)clear;

@end

