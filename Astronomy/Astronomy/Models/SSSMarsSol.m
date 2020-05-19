//
//  SSSMarsSol.m
//  Astronomy
//
//  Created by Shawn Gee on 5/18/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import "SSSMarsSol.h"

@implementation SSSMarsSol

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (!self) { return nil; }
    
    NSNumber *solNumber = dictionary[@"sol"];
    NSNumber *numPhotos = dictionary[@"total_photos"];
    _solNumber = solNumber.intValue;
    _numPhotos = numPhotos.intValue;
    
    return self;
}

@end
