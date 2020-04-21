//
//  JLCMarsPhoto.m
//  iOS9-Astronomy
//
//  Created by Jake Connerly on 11/12/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

#import "JLCMarsPhoto.h"
#import "iOS9-Astronomy-Bridging-Header.h"
#import "iOS9_Astronomy-Swift.h"


@implementation JLCMarsPhoto

- (instancetype)initWithID:(double)identifier sol:(double)sol camera:(JLCCamera *)camera rover:(JLCMarsRover *)rover earthDate:(NSString *)earthDate imageURL:(NSURL *)imageURL {
    if (self = [super init]) {
        _identifier = identifier;
        _sol = sol;
        _camera = camera;
        _rover = rover;
        _earthDate = earthDate;
        _imageURL = imageURL;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)photoDictionary {
    NSString *identifierStr = photoDictionary[@"id"];
    double identifier = [identifierStr doubleValue];
    NSString *solStr = photoDictionary[@"sol"];
    double sol = [solStr doubleValue];
    JLCCamera *camera = photoDictionary[@"camera"];
    JLCMarsRover *rover = photoDictionary[@"rover"];
    NSString *earthDateStr = photoDictionary[@"earth_date"];
    NSString *imageURLString = photoDictionary[@"img_src"];
    NSURL *imageURL = [[NSURL alloc] initWithString:imageURLString].usingHTTPS;
    
    return [self initWithID:identifier sol:sol camera:camera rover:rover earthDate:earthDateStr imageURL:imageURL];
}

@end
