//
//  BYSolDescription.m
//  Astronomy-objc
//
//  Created by Bradley Yin on 10/14/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

#import "BYSolDescription.h"

@implementation BYSolDescription

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        _sol = dictionary[@"sol"];
        _totalPhotos = dictionary[@"total_photos"];
        _cameras = dictionary[@"cameras"];
    }
    return self;
}

@end
