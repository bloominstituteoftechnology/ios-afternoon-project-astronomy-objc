//
//  LSICache.h
//  Astronomy
//
//  Created by David Wright on 6/10/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_SWIFT_NAME(Cache)
@interface LSICache<Value> : NSObject

- (void)cacheValue:(nonnull Value)value ForKey:(nonnull NSNumber *)key;
- (nullable Value)valueForKey:(nonnull NSNumber *)key;
- (void)clear;

@end
