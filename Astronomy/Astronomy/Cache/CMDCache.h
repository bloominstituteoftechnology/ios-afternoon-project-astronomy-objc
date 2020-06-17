//
//  CMDCache.h
//  Astronomy
//
//  Created by Chris Dobek on 6/17/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMDCache : NSObject

@property NSObject *value;

- (_Nullable id)valueForKey:(NSString *)key;
- (void)cacheValue:(id)value forKey:(NSString *)key;
- (void)clear;

- (instancetype)initWithKey:(NSString *)key value:(id)value;


@end

NS_ASSUME_NONNULL_END
