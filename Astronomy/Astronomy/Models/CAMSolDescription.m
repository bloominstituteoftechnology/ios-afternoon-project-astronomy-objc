//
//  CAMSolDescription.m
//  Astronomy
//
//  Created by Cody Morley on 7/20/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

#import "CAMSolDescription.h"

@implementation CAMSolDescription

- (instancetype)initWithSol:(int)sol
                totalPhotos:(int)totalPhotos
                    cameras:(NSArray<NSString *> *)cameras
{
    self = [super init];
    if (self) {
        _sol = sol;
        _totalPhotos = totalPhotos;
        _cameras = [cameras copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSNumber *sol = dictionary[@"sol"];
    NSNumber *totalPhotos = dictionary[@"totalPhotos"];
    NSArray <NSString *> *cameras = dictionary[@"cameras"];
    
    return [self initWithSol: sol.intValue
                 totalPhotos: totalPhotos.intValue
                     cameras: cameras];
    
}


@end
