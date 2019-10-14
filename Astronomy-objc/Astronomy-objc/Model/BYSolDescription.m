//
//  BYSolDescription.m
//  Astronomy-objc
//
//  Created by Bradley Yin on 10/14/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

#import "BYSolDescription.h"

@implementation BYSolDescription

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cameras = [[NSArray alloc] init];
    }
    return self;
}

@end
