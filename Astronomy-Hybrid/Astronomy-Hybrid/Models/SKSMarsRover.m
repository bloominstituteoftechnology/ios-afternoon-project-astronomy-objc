//
//  SKSMarsRover.m
//  Astronomy-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "SKSMarsRover.h"
#import "Astronomy_Hybrid-Swift.h"

@interface SKSMarsRover()

- (void)dateFormatter;

@end

@implementation SKSMarsRover

- (instancetype _Nullable)initWithName:(nonnull NSString *)name
                           landingDate:(nonnull NSDate *)landingDate
                            launchDate:(nonnull NSDate *)launchDate
                                maxSol:(int)maxSol
                           totalPhotos:(int)totalPhotos
                       solDescriptions:(nonnull NSArray<SolDescription *> *)solDescriptions {
    self = [super init];
    if (self) {
        _name = name;
        _landingDate = landingDate;
        _launchDate = launchDate;
        _maxSol = maxSol;
        _totalPhotos = totalPhotos;
        _solDescriptions = solDescriptions;
    }
    return self;
}

- (instancetype _Nullable)initWithDictionary:(nullable NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    NSLog(@"Name: %@", name);
    NSDate *landingDate = dictionary[@"landing_date"];
    NSDate *launchDate = dictionary[@"launch_date"];
    NSLog(@"Launch Date: %@", launchDate);
    NSNumber *maxSol = dictionary[@"max_sol"];
    NSNumber *totalPhotos = dictionary[@"total_photos"];
    NSArray *photoDictionaries = dictionary[@"photos"];

    NSMutableArray<SolDescription *> *solDescriptions = [[NSMutableArray alloc] init];
    for (NSDictionary *photoDictionary in photoDictionaries) {
        SolDescription *sol = [[SolDescription alloc] initWithDictionary:photoDictionary];
        [solDescriptions addObject:sol];
    }

    NSLog(@"Sol Description: %lu", solDescriptions[4].sol);
    
    return [self initWithName:name landingDate:landingDate launchDate:launchDate maxSol:[maxSol intValue] totalPhotos:[totalPhotos intValue] solDescriptions:solDescriptions];
}

- (void)dateFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [formatter setDateFormat: @"yyyy-MM-dd"];
}

@end
