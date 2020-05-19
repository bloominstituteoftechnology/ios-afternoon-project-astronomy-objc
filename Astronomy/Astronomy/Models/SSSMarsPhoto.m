//
//  SSSMarsPhoto.m
//  Astronomy
//
//  Created by Shawn Gee on 5/18/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import "SSSMarsPhoto.h"

@implementation SSSMarsPhoto

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (!self) { return nil; }
    
    NSNumber *solNumber = dictionary[@"sol"];
    NSString *earthDate = dictionary[@"earth_date"];
    NSString *imageURLString = dictionary[@"img_src"];
    
    NSDictionary *cameraContainer = dictionary[@"camera"];
    NSString *cameraName = cameraContainer[@"full_name"];
    NSNumber *roverID = cameraContainer[@"rover_id"];
    
    _solNumber = solNumber.intValue;
    _earthDate = earthDate;
    _imageURL = [NSURL URLWithString:imageURLString];
    _cameraName = cameraName;
    _roverID = roverID.intValue;
    
    return self;
}

@end
