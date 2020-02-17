//
//  VVSMarsRover.m
//  Astronomy-Hybrid
//
//  Created by Vici Shaweddy on 2/12/20.
//  Copyright © 2020 Vici Shaweddy. All rights reserved.
//

#import "VVSMarsRover.h"

@implementation VVSMarsRover

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _name = dictionary[@"name"];
        // _launchDate = dictionary[@"launch_date"];
        // _landingDate = dictionary[@"landing_date"];
        // _maxDate = dictionary[@"max_date"];
        
        if ([dictionary[@"status"] isEqual:@"active"]) {
            _status = Active;
        } else {
            _status = Complete;
        }
        
        _maxSol = [dictionary[@"max_sol"] integerValue];
        _numberOfPhotos = [dictionary[@"total_photos"] integerValue];
        
        NSArray<NSDictionary *> *photos = dictionary[@"photos"];
        NSMutableArray *solDescription = [[NSMutableArray alloc] init];
        for (NSDictionary *photo in photos) {
            VVSSolDescription *sol = [[VVSSolDescription alloc] initWithDictionary: photo];
            [solDescription addObject:sol];
        }
        _solDescription = solDescription;
    }
    
    return self;
}

@end
