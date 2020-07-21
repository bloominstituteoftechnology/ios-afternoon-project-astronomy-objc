//
//  EJSSolPhoto.m
//  Swift
//
//  Created by Enzo Jimenez-Soto on 7/21/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

#import "EJSSolPhoto.h"

@implementation EJSSolPhoto

- (instancetype)initWithSolid:(NSNumber *)solId imageUrl:(NSString *)imageUrl earthDate:(NSDate *)earthDate {
    self = [super init];
    if (self) {
        _solId = solId;
        _imageUrl = imageUrl;
        _earthDate = earthDate;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSNumber *solId = dictionary[@"sol"];
    NSString *imageUrl = dictionary[@"img_src"];
    NSString *dateString = dictionary[@"earth_date"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *earthDate = [formatter dateFromString:dateString];
    
    self = [self initWithSolid:solId imageUrl:imageUrl earthDate:earthDate];
    
    return self;
}

@end
