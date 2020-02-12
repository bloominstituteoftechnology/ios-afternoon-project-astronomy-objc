//
//  SolDescription.m
//  Astronomy-Hybrid
//
//  Created by Bobby Keffury on 2/12/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

#import "SolDescription.h"

@interface SolDescription ()

@property (nonatomic) NSMutableArray *internalCameras;

@end

@implementation SolDescription

- (NSArray *)cameras
{
    return _internalCameras.copy;
}

@end
