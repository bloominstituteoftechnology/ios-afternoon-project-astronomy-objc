//
//  NPTSol.m
//  AstronomyObjC
//
//  Created by Nick Nguyen on 4/21/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

#import "NPTSol.h"
static NSDateFormatter *_dateFormatter;
@interface NPTSol ()

+ (NSDateFormatter *)dateFormatter;

@end

@implementation NPTSol
- (instancetype) initWithIdNumber:(NSNumber *)idNumber
                              sol:(NSNumber *)sol
                         imageURL:(NSString *)imageURL
                           camera:(NPTMarsCamera *)camera
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
    NSDate *earthDate = [[NPTSol dateFormatter] dateFromString:earthDateString];
    NSDictionary *cameraDictionary = dictionary[@"camera"];
    NPTMarsCamera *camera = [[NPTMarsCamera alloc] initWithDictionary:cameraDictionary];
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
