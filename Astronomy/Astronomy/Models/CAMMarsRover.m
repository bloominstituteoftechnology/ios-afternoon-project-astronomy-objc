//
//  CAMMarsRover.m
//  Astronomy
//
//  Created by Cody Morley on 7/20/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

#import "CAMMarsRover.h"
#import "CAMSolDescription.h"

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
        [self setupDateFormatter];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    NSString *status = dictionary[@"status"];
    
    NSDate *launchDate = dictionary[@"launch_date"];
    NSDate *landingDate = dictionary[@"landing_date"];
    NSDate *maxDate = dictionary[@"max_date"];
    
    NSNumber *maxSol = dictionary[@"max_sol"];
    NSNumber *numberOfPhotos = dictionary[@"number_of_photos"];
    
    NSArray <CAMSolDescription *> *solDescriptions = dictionary[@"sol_descriptions"];
    
    return [self initWithName: name
                   launchDate: launchDate
                  landingDate: landingDate
                       status: status
                       maxSol: [maxSol intValue]
                      maxDate: maxDate
               numberOfPhotos: [numberOfPhotos intValue]
              solDescriptions: solDescriptions];
}

- (void)setupDateFormatter
{
    self.dateFormatter.locale = [NSLocale localeWithLocaleIdentifier: @"en_US_POSIX"];
    self.dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation: @"GMT"];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
}

@end
