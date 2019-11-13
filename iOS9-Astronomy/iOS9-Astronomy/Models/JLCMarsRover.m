//
//  JLCMarsRover.m
//  iOS9-Astronomy
//
//  Created by Jake Connerly on 11/12/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

#import "JLCMarsRover.h"

@implementation JLCMarsRover

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)roverDictionary {
    NSDictionary *internalRoverDictionary = roverDictionary[@"rover"];
    NSString *name = internalRoverDictionary[@"name"];
    
    return [self initWithName:name];
}

@end
