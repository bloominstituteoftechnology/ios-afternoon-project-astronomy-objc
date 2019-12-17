//
//  GIPMarsRover.m
//  Astronomy Objc
//
//  Created by Gi Pyo Kim on 12/16/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

#import "GIPMarsRover.h"
#import "GIPSol.h"

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

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    
    NSNumber *maxSolNumber = dictionary[@"max_sol"];
    int maxsol = [maxSolNumber intValue];
    
    NSArray *sols = dictionary[@"photos"];
    NSMutableArray<GIPSol *> *solArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dict in sols) {
        [solArray addObject:[[GIPSol alloc] initWithDictionary:dict]];
    }
    
    if (!name || !maxsol || !solArray) {
        return nil;
    }
    
    return [self initWithName:name maxSol:maxsol sols:solArray];
    
}

@end

