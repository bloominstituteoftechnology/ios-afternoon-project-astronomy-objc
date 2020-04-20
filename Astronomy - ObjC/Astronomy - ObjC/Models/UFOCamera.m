//
//  UFOCamera.m
//  Astronomy - ObjC
//
//  Created by Ufuk Türközü on 20.04.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

#import "UFOCamera.h"

@implementation UFOCamera

static NSString const *idKey = @"id";
static NSString const *nameKey = @"name";
static NSString const *roverIdKey =  @"rover_id";
static NSString const *fullNameKey = @"full_name";

- (instancetype) initWithIdentifier:(int) identifier
                               name:(NSString *)name
                            roverId:(int)roverId
                           fullName:(NSString *)fullName {
    self = [super init];
    if (self) {
        _identifier = identifier;
        _name = name;
        _roverId = roverId;
        _fullName = fullName;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self) {
        _identifier = [dictionary[idKey] intValue];
        _name = dictionary[nameKey];
        _roverId = [dictionary[roverIdKey] intValue];
        _fullName = dictionary[fullNameKey];
    }
    return self;
}

@end
