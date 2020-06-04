//
//  CATSolDescription.m
//  Astronomy
//
//  Created by Jessie Ann Griffin on 6/3/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

#import "CATSolDescription.h"

@implementation CATSolDescription

- (instancetype)initWithSol:(int)aSol
                totalPhotos:(int)totalPhotosCount
                    cameras:(NSArray<NSString *> *)allCameras
{
    if (self = [super init]) {
        _sol = aSol;
        _totalPhotos = totalPhotosCount;
        _cameras = allCameras;
    }
    return self;
}

@end
