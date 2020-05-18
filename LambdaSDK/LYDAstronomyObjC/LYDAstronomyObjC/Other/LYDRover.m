//
//  LYDRover.m
//  LYDAstronomyObjC
//
//  Created by Lydia Zhang on 5/18/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

#import "LYDRover.h"
#import "LYDSol.h"

@implementation LYDRover

+ (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
    });
    return dateFormatter;
}

- (instancetype)initWithDictionary:(NSDictionary *)roverDictionary{
    self = [super init];
    if (self) {
        NSDictionary *manifestDictionary = roverDictionary[@"photo_manifest"];
        NSArray *photoRaw = manifestDictionary[@"photos"];
        NSMutableArray *photos = [[NSMutableArray alloc] init];

        _name = manifestDictionary[@"name"];
        _launchDate = [[[self class] dateFormatter] dateFromString:manifestDictionary[@"launch_date"]];
        _landingDate = [[[self class] dateFormatter] dateFromString:manifestDictionary[@"landing_date"]];
        _maxSol = [manifestDictionary[@"max_sol"] intValue];
        _maxDate = [[[self class] dateFormatter] dateFromString:manifestDictionary[@"max_date"]];
        _numberOfPhotos = [manifestDictionary[@"total_photos"] intValue];

        for (NSDictionary *photoDict in photoRaw) {
            [photos addObject:[[LYDSol alloc] initWithDictionary:photoDict]];
        }
        _solArray = photos;
    }
    return self;
}

@end
