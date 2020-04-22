//
//  UFOMarsPhoto.m
//  Astronomy - ObjC
//
//  Created by Ufuk Türközü on 20.04.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

#import "UFOMarsPhoto.h"
#import "UFOCamera.h"

@implementation UFOMarsPhoto

static NSString const *idKey = @"id";
static NSString const *solKey = @"sol";
static NSString const *cameraKey =  @"camera";
static NSString const *imageKey = @"img_src";
static NSString const *dateKey =  @"earth_date";

- (instancetype) initWithIdentifier:(int) identifier
                                sol:(int)sol
                             camera:(UFOCamera *)camera
                             imgSrc:(NSURL *)imgSrc
                          earthDate:(NSDate *)earthDate {
    self = [super init];
    if (self) {
        _identfier = identifier;
        _sol = sol;
        _camera = camera;
        _earthDate = earthDate;
        _imgSrc = imgSrc;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _identfier = [dictionary[idKey] intValue];
        _sol = [dictionary[solKey] intValue];
        _camera = dictionary[cameraKey];
        _earthDate = dictionary[dateKey];
        _imgSrc = dictionary[imageKey];
    }
    return self;
}

@end
