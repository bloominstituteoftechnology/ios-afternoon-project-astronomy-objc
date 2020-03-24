//
//  MBMCamera.m
//  Astronomy-Objc
//
//  Created by Michael on 3/23/20.
//  Copyright © 2020 Michael. All rights reserved.
//

#import "MBMCamera.h"

@implementation MBMCamera

- (instancetype)initWithIdentifier:(int)identifier
                              name:(NSString *)name
                           roverID:(int)roverID
                          fullName:(NSString *)fullName {
    self = [super init];
    if (self) {
        _identifier = identifier;
        _name = name;
        _roverID = roverID;
        _fullName = fullName;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    NSNumber *identifier = dictionary[@"id"];
    NSString *name = dictionary[@"name"];
    NSNumber *roverID = dictionary[@"rover_id"];
    NSString *fullName = dictionary[@"full_name"];
    
    self = [self initWithIdentifier:identifier.intValue
                               name:name
                            roverID:roverID.intValue
                           fullName:fullName];
    
    return self;
}

@end
