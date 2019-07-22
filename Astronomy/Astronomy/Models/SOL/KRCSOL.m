//
//  KRCSOL.m
//  Astronomy
//
//  Created by Christopher Aronson on 7/22/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

#import "KRCSOL.h"

@implementation KRCSOL

- (instancetype)initWithSol:(NSNumber *)sol {
    
    self = [super init];
    
    if (self) {
        _sol = sol;
    }
    
    return self;
}

@end
