//
//  CARMarsSol.m
//  CARAstronomy
//
//  Created by Chad Rutherford on 2/24/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import "CARMarsSol.h"

static NSDateFormatter *_dateFormatter;

@interface CARMarsSol ()

+(NSDateFormatter *)dateFormatter;

@end

@implementation CARMarsSol

// https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=E1mvXHcz2wixp2XkoacEfdqeZUomUQZXNdm4j13Z

- (instancetype) initWithIdNumber:(NSNumber *)idNumber
                              sol:(NSNumber *)sol
                         imageURL:(NSString *)imageURL
                           camera:(CARMarsCamera *)camera
                        earthDate:(NSDate *)earthDate {
    self = [super init];
    if (self) {
        _idNumber = idNumber;
        _sol = sol;
        _imageURL = [imageURL copy];
        _camera = camera;
        _earthDate = earthDate;
    }
    return self;
}

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    NSNumber *idNumber = dictionary[@"id"];
    NSNumber *sol = dictionary[@"sol"];
    NSString *imageURL = dictionary[@"img_src"];
    NSString *earthDateString = dictionary[@"earth_date"];
    NSDate *earthDate = [[CARMarsSol dateFormatter] dateFromString:earthDateString];
    NSDictionary *cameraDictionary = dictionary[@"camera"];
    CARMarsCamera *camera = [[CARMarsCamera alloc] initWithDictionary:cameraDictionary];
    self = [self initWithIdNumber:idNumber sol:sol imageURL:imageURL camera:camera earthDate:earthDate];
    return self;
}

+ (NSDateFormatter *)dateFormatter {
    if (_dateFormatter) {
        return _dateFormatter;
    } else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-DD"];
        return formatter;
    }
}

@end
