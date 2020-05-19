//
//  TMCCache.h
//  AstronomyObjC
//
//  Created by Lydia Zhang on 5/19/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(Cache)

@interface TMCCache<Key, Value> : NSObject

- (void)cache:(Value)object forKey:(Key)key;

- (nullable Value)ObjectByKey:(Key)key;

@end

NS_ASSUME_NONNULL_END
