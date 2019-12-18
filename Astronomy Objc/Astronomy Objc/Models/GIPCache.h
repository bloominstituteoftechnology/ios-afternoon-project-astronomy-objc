//
//  GIPCache.h
//  Astronomy Objc
//
//  Created by Gi Pyo Kim on 12/17/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(Cache)

@interface GIPCache : NSObject

- (void)cacheValue:(nonnull NSObject *)value key:(nonnull NSObject *)key;
- (nullable NSObject *)valueFor:(nonnull NSObject *)key;
- (void)clear;

@end

