//
//  LSISol.m
//  Astronomy-Hybrid
//
//  Created by Isaac Lyons on 12/16/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

#import "LSISol.h"

@implementation LSISol

- (instancetype)initWithSol:(int)sol totalPhotos:(int)totalPhotos {
    self = [super init];
    if (self) {
        _sol = sol;
        _totalPhotos = totalPhotos;
    }
    return self;
}

@end
