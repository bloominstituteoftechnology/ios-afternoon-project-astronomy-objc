//
//  CMDManifest.m
//  Astronomy
//
//  Created by Chris Dobek on 6/15/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

#import "CMDManifest.h"

@implementation CMDManifest

-(instancetype)initWithSolID:(int)solID photoCount:(int)photoCount cameras:(NSArray<NSString *> *)cameras
{
    self = [super init];
    if (self) {
        _solID = solID;
        _photoCount = photoCount;
        _cameras = cameras;
    }
    return self;
}

@end
