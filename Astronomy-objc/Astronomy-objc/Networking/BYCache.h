//
//  Cache.h
//  Astronomy-objc
//
//  Created by Bradley Yin on 10/14/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BYCache: NSCache

- (void)cacheValueForKey:(NSString * _Nonnull)key value:(NSData * _Nonnull)value;
- (NSData * _Nullable)valueForKey:(NSString * _Nonnull)key;

@end

