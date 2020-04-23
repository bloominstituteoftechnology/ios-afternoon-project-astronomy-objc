//
//  CDGCache.h
//  AstronomyObjC
//
//  Created by Chris Gonzales on 4/23/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDGCache : NSObject

- (void)cacheValue:(Value)value forKey:(Key)key;
- (Value _Nullable)cachedValueForKey:(Key)key;
- (void)clear;

@end

NS_ASSUME_NONNULL_END
