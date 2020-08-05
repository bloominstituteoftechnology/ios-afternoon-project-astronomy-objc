//
//  Cache.h
//  AstronomyOBJc
//
//  Created by Kelson Hartle on 7/30/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Cache<Key ,Value> : NSObject

- (void)cacheValue:(Value _Nonnull)value
            forKey:(Key _Nonnull)key;

- (nullable Value)valueForKey:(Key _Nonnull)key;




@end

NS_ASSUME_NONNULL_END
