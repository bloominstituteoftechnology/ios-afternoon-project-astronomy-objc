//
//  JLRMarsRover.h
//  Astronomy
//
//  Created by Jesse Ruiz on 12/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLRMarsRover : NSObject

@property (nonatomic, copy, readonly, nonnull) NSString *name;

- (nonnull instancetype)initWithName:(nonnull NSString *)name;

- (nullable instancetype)initWithRoverDictionary:(nonnull NSDictionary *)roverDictionary;

@end
