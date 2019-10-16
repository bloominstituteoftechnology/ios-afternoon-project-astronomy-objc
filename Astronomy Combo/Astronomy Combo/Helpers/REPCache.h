//
//  REPCache.h
//  Astronomy Combo
//
//  Created by Michael Redig on 10/14/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(Cache)
@interface REPCache : NSObject

- (void)cacheItemWithKey:(NSString * _Nonnull)key item:(NSData * _Nonnull)data;
- (NSData * _Nullable)itemForKey:(NSString * _Nonnull)key;

@end
