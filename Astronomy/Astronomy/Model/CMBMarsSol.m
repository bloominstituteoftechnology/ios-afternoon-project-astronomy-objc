//
//  CMBMarsSol.m
//  Astronomy
//
//  Created by Craig Belinfante on 12/6/20.
//

#import "CMBMarsSol.h"

@implementation CMBMarsSol

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (!self) { return nil; }
    
    NSNumber *solNumber = dictionary[@"sol"];
    _solNumber = solNumber.intValue;
    
    return self;
}

@end
