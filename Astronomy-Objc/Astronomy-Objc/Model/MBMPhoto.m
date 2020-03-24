//
//  MBMPhoto.m
//  Astronomy-Objc
//
//  Created by Michael on 3/23/20.
//  Copyright © 2020 Michael. All rights reserved.
//

#import "MBMPhoto.h"

@implementation MBMPhoto

- (instancetype)initWithIdentifier:(int)identifier
                               sol:(int)sol
                            camera:(MBMCamera *)camera
                            imgSrc:(NSString *)imgSrc
                         earthDate:(NSDate *)earthDate {
    self = [super init];
    if (self) {
        _identifier = identifier;
        _sol = sol;
        _camera = camera;
        _imgSrc = imgSrc;
        _earthDate = earthDate;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"yyy-MM-dd"];
    
    NSNumber *identifier = dictionary[@"id"];
    NSNumber *sol = dictionary[@"sol"];
    MBMCamera *camera = dictionary[@"camera"];
    NSString *imgSrc = dictionary[@"img_src"];
    NSString *earthDate = dictionary[@"earth_date"];
    
    self = [self initWithIdentifier:identifier.intValue
                                sol:sol.intValue
                             camera:camera
                             imgSrc:imgSrc
                          earthDate:[dateFormatter dateFromString:earthDate]];
    
    return self;
}

@end
