//
//  VVSSolDescription.m
//  Astronomy-Hybrid
//
//  Created by Vici Shaweddy on 2/13/20.
//  Copyright © 2020 Vici Shaweddy. All rights reserved.
//

#import "VVSSolDescription.h"

@implementation VVSSolDescription

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _sol = [dictionary[@"sol"] integerValue];
        _totalPhotos = [dictionary[@"totalPhotos"] integerValue];
        _cameras = dictionary[@"cameras"];
    }
    return self;
}

@end
