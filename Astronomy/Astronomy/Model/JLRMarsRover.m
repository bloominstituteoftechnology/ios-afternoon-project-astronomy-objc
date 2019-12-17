//
//  JLRMarsRover.m
//  Astronomy
//
//  Created by Jesse Ruiz on 12/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

#import "JLRMarsRover.h"
#import "JLRSolDescription.h"

@implementation JLRMarsRover

- (nonnull instancetype)initWithName:(nonnull NSString *)name
                     solDescriptions:(nonnull NSArray<JLRSolDescription *> *)solDescriptions {
    self = [super init];
    if (self) {
        _name = [name copy];
        _solDescriptions = [solDescriptions copy];
    }
    return self;
}

- (nullable instancetype)initWithRoverDictionary:(nonnull NSDictionary *)roverDictionary {
    NSString *name = roverDictionary[@"name"];
    NSArray<JLRSolDescription *> *solDescriptions = roverDictionary[@"sol_descriptions"];
    
    if (!name || !solDescriptions) {
        return nil;
    }
    return [self initWithName:name solDescriptions:solDescriptions];
}

@end
