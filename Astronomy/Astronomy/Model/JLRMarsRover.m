//
//  JLRMarsRover.m
//  Astronomy
//
//  Created by Jesse Ruiz on 12/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

#import "JLRMarsRover.h"

@implementation JLRMarsRover

- (nonnull instancetype)initWithName:(nonnull NSString *)name
{
    self = [super init];
    if (self) {
        _name = [name copy];
    }
    return self;
}

- (nullable instancetype)initWithRoverDictionary:(nonnull NSDictionary *)roverDictionary
{
    NSString *name = roverDictionary[@"name"];
    
    if (!name) {
        return nil;
    }
    return [self initWithName:name];
}

@end
