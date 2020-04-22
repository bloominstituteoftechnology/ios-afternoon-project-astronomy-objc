//
//  UFOMarsRover.m
//  Astronomy - ObjC
//
//  Created by Ufuk Türközü on 21.04.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

#import "UFOMarsRover.h"
#import "UFOMarsPhoto.h"
#import "UFOCamera.h"

@implementation UFOMarsRover

static NSString const *nameKey = @"name";
static NSString const *launchDateKey = @"launch_date";
static NSString const *landingDateKey =  @"landing_date";
static NSString const *statusKey = @"status";
static NSString const *maxSolKey =  @"max_sol";
static NSString const *maxDateKey =  @"max_date";
static NSString const *totalPhotosKey =  @"total_photos";
static NSString const *camerasKey =  @"cameras";

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _name = dictionary[nameKey];
        _launchDate = dictionary[launchDateKey];
        _landingDate = dictionary[landingDateKey];
        _status = dictionary[statusKey];
        _maxSol = [dictionary[maxSolKey] intValue];
        _maxDate = dictionary[maxDateKey];
        _totalPhotos = [dictionary[totalPhotosKey] intValue];
        _cameras = dictionary[camerasKey];
    }
    return self;
}

@end
