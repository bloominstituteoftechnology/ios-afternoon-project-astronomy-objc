//
//  JLCMarsRover.m
//  iOS9-Astronomy
//
//  Created by Jake Connerly on 11/12/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

#import "JLCMarsRover.h"

@implementation JLCMarsRover

- (instancetype)initWithName:(NSString *)name maxSol:(double)maxSol {
    self = [super init];
    if (self) {
        _name = name;
        _maxSol = maxSol;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)roverDictionary {
    NSString *name = roverDictionary[@"name"];
    NSString *maxSolStr = roverDictionary[@"max_sol"];
    double maxSol = [maxSolStr doubleValue];
    
    return [self initWithName:name maxSol:maxSol];
}

@end
