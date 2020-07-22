//
//  EJSSol.m
//  Swift
//
//  Created by Enzo Jimenez-Soto on 7/21/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

#import "EJSSol.h"

@implementation EJSSol

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
