//
//  TMCSolDescription.m
//  AstronomyObjC
//
//  Created by Christopher Devito on 5/18/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import "TMCSolDescription.h"

@implementation TMCSolDescription
-(instancetype) initWithSol:(NSNumber *)sol totalPhotos:(NSNumber *) totalPhotos cameras:(NSMutableArray *) cameras {
    self = [super init];
    if (self) {
    _sol = sol;
    _totalPhotos = totalPhotos;
    _cameras = cameras;
    }
    return self;
}

@end
