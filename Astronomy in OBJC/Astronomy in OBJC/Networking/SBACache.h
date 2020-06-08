//
//  SBACache.h
//  Astronomy-in-OBJC
//
//  Created by Sal B Amer on 6/4/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(Cache)

@interface SBACache<Key, Value> : NSObject

- (void)cache:(Value)object forKey:(Key)key;

- (nullable Value)ObjectByKey:(Key)key;

@end

NS_ASSUME_NONNULL_END
