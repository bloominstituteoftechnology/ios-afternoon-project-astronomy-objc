//
//  Photo.m
//  Astronomy-objc
//
//  Created by Dillon P on 4/27/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (instancetype)initWithSol:(int)sol
{
    if (self = [super init]) {
        _sol = sol;
    }
    return self;
}

@end
