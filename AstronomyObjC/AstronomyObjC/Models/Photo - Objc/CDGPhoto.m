//
//  CDGPhoto.m
//  AstronomyObjC
//
//  Created by Chris Gonzales on 4/21/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

#import "CDGPhoto.h"
#import "CDGCamera.h"

@implementation CDGPhoto

+ (NSDateFormatter *)dateFormatter
{
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

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        if (!dictionary[@"id"]) { return nil; }
        _identifier = [dictionary[@"id"] integerValue];
        _sol = [dictionary[@"sol"] integerValue];
        _camera = [[CDGCamera alloc] initWithDictionary:dictionary[@"camera"]];
        NSString *earthDateString = dictionary[@"earth_date"];
        _earthDate = [[[self class] dateFormatter] dateFromString:earthDateString];
        _imageURL = [NSURL URLWithString:dictionary[@"img_src"]];
        if (!_imageURL) { return nil; }
    }
    return self;
}

@end
