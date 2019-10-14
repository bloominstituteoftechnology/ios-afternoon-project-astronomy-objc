//
//  REPCache.h
//  Astronomy Combo
//
//  Created by Michael Redig on 10/14/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface REPCache : NSObject

- (void)cacheItemWithKey:(NSString *)key item:(NSData *)data;
- (NSData *)itemForKey:(NSString *)key;

@end
