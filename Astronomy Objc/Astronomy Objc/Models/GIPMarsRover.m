//
//  GIPMarsRover.m
//  Astronomy Objc
//
//  Created by Gi Pyo Kim on 12/16/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

#import "GIPMarsRover.h"

@implementation GIPMarsRover

- (nonnull instancetype)initWithName:(nonnull NSString *)name maxSol:(int)maxSol sols:(nonnull NSArray<GIPSol *>*)sols {
    self = [super init];
    if (self) {
        _name = name;
        _maxSol = maxSol;
        _sols = sols;
    }
    return self;
}

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionatry {
    NSString *name = dictionatry[@"name"];
    
    NSNumber *maxSolNumber = dictionatry[@"max_sol"];
    int maxsol = [maxSolNumber intValue];
    
    NSArray *sols = dictionatry[@"photos"];
    
    if (!name || !maxsol || !sols) {
        return nil;
    }
    
    return [self initWithName:name maxSol:maxsol sols:sols];
    
}

@end

