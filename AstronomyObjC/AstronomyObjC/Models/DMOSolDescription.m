//
//  DMOSolDescription.m
//  AstronomyObjC
//
//  Created by morse on 1/26/20.
//  Copyright © 2020 morse. All rights reserved.
//

#import "DMOSolDescription.h"

@implementation DMOSolDescription

- (instancetype)initWithSol:(int)sol {
    self = [super init];
    if (self) {
        _sol = sol;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    int sol = [dictionary[@"sol"] intValue];
    return [self initWithSol:sol];
}

@end
