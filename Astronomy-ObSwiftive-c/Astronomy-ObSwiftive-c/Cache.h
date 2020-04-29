//
//  Cache.h
//  Astronomy-ObSwiftive-c
//
//  Created by Craig Swanson on 4/27/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Cache : NSObject

@property (nonatomic, nullable) NSMutableDictionary *cache;
@property (nonatomic, nullable) dispatch_queue_t queue;

- (void)cache:(NSNumber * _Nullable )key forValue:(id _Nullable)value;
- (id _Nullable)value:(NSNumber * _Nullable)key;
- (id _Nullable)removeValue:(NSNumber * _Nullable)key;
- (void)clear;

@end
