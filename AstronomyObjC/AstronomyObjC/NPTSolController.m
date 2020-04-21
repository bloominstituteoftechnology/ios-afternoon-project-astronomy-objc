//
//  NPTSolController.m
//  AstronomyObjC
//
//  Created by Nick Nguyen on 4/21/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

#import "NPTSolController.h"
#import "AstronomyObjC-Swift.h"
#import "NPTMarsCamera.h"

static NSDateFormatter *_dateFormatter;

@interface NPTSolController ()
+ (NSDateFormatter *)dateFormatter;

@end


@implementation NPTSolController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (instancetype _Nullable )initWithDictionary:(NSDictionary *_Nullable)dictionary {
    NSNumber *idNumber = dictionary[@"id"];
    NSNumber *sol = dictionary[@"sol"];
    NSString *imageURL = dictionary[@"img_src"];
    NSString *earthDateString = dictionary[@"earth_date"];
    NSDate *earthDate = [[NPTSolController dateFormatter] dateFromString:earthDateString];
    NSDictionary *cameraDictionary = dictionary[@"camera"];
    NPTMarsCamera *camera = [[NPTMarsCamera alloc] initWithDictionary:cameraDictionary];
    self = []
    
    
    
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
