//
//  SAHSol.m
//  Astronomy-ObjC
//
//  Created by scott harris on 4/20/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

#import "SAHSol.h"

@implementation SAHSol

- (instancetype)initWithIdentifier:(int)identifier earthDate:(NSDate *)earthDate totalPhotos:(int)totalPhotos {
    self = [super init];
    if (self) {
        _identifier = identifier;
        _earthDate = earthDate;
        _totalPhotos = totalPhotos;
    }
    
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSNumber *idNumber = dictionary[@"sol"];
    NSString *dateString = dictionary[@"earth_date"];
    NSNumber *photosNumber = dictionary[@"total_photos"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *earthDate = [formatter dateFromString:dateString];
    
    self = [self initWithIdentifier:idNumber.intValue earthDate:earthDate totalPhotos:photosNumber.intValue];
    
    return self;
    
}


@end
