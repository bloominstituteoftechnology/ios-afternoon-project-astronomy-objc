//
//  JLCMarsPhoto.m
//  iOS9-Astronomy
//
//  Created by Jake Connerly on 11/12/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

#import "JLCMarsPhoto.h"

@implementation JLCMarsPhoto

- (instancetype)initWithID:(double)identifier sol:(double)sol camera:(JLCCamera *)camera earthDate:(NSString *)earthDate imageURL:(NSURL *)imageURL {
    if (self = [super init]) {
        _identifier = identifier;
        _sol = sol;
        _camera = camera;
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
    NSString *earthDateStr = photoDictionary[@"earth_date"];
    NSString *imageURLString = photoDictionary[@"img_src"];
    NSURL *imageURL = [[NSURL alloc] initWithString:imageURLString];
    
    return [self initWithID:identifier sol:sol camera:camera earthDate:earthDateStr imageURL:imageURL];
}

@end
