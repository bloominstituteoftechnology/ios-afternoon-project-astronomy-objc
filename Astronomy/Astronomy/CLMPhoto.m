//
//  CLMPhoto.m
//  Astronomy
//
//  Created by Claudia Maciel on 8/6/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

#import "CLMPhoto.h"
#import "Astronomy-Swift.h"

@implementation CLMPhoto

- (instancetype) initWithPhotoId:(NSNumber *)photoId sol:(NSNumber *)sol imgURL:(NSURL *)imgURL earthDate:(NSDate *)earthDate rover:(Rover *)rover
{
    self = [super init];
    
    if(self)
    {
        _photoId = photoId;
        _sol = sol;
        _imgURL = imgURL;
        _earthDate = earthDate;
        _rover = rover;
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];

    NSNumber *photoID = dictionary[@"id"];
    NSNumber *sol = dictionary[@"sol"];
    NSURL *imgURL = [NSURL URLWithString:dictionary[@"img_src"]];
    NSDate *earthDate = [formatter dateFromString:dictionary[@"earth_date"]];

    // Set up rover
    NSDictionary *roverDictionary = dictionary[@"rover"];

    NSNumber *roverId = roverDictionary[@"id"];
    NSString *name = roverDictionary[@"name"];
    NSDate *landingDate = [formatter dateFromString:roverDictionary[@"landing_date"]];
    NSDate *launchDate = [formatter dateFromString:roverDictionary[@"launch_date"]];
    NSString *status = roverDictionary[@"status"];


    Rover *rover = [[Rover alloc] initWithId:roverId.intValue name:name landingDate:landingDate launchDate:launchDate status:status];

    self = [self initWithPhotoId:photoID sol:sol imgURL:imgURL earthDate:earthDate rover:rover];
    return self;
}

@end
