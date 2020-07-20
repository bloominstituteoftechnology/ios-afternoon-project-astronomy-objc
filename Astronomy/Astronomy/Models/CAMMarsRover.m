//
//  CAMMarsRover.m
//  Astronomy
//
//  Created by Cody Morley on 7/20/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

#import "CAMMarsRover.h"

@implementation CAMMarsRover

-(instancetype)initWithName:(NSString *)name
                 launchDate:(NSDate *)launchDate
                landingDate:(NSDate *)landingDate
                     status:(NSString *)status
                     maxSol:(int)maxSol
                    maxDate:(NSDate *)maxDate
             numberOfPhotos:(int)numberOfPhotos
            solDescriptions:(NSArray<CAMSolDescription *> *)solDesriptions
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _launchDate = [launchDate copy];
        _landingDate = [landingDate copy];
        _status = [status copy];
        _maxSol = maxSol;
        _maxDate = [maxDate copy];
        _numberOfPhotos = numberOfPhotos;
        _solDescriptions = solDesriptions;
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self newDateFormatter];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    
}

- (void)newDateFormatter:
{
    self.dateFormatter.
}

@end
