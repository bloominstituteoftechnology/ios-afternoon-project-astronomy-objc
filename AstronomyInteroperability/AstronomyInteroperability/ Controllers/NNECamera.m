//
//  Camera.m
//  AstronomyInteroperability
//
//  Created by Nonye on 7/20/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

#import "NNECamera.h"

@implementation NNECamera

- (instancetype)initWithID:(int)cameraID roverID:(int)roverID name:(NSString *)name fullName:(NSString *)fullName
{
    self = [super init];
    if (self) {
        _cameraID = cameraID;
        _name = [name copy];
        _roverID = roverID;
        _fullName = [fullName copy];
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSNumber *cameraID = dictionary[@"id"];
    NSNumber *roverID = dictionary[@"roverId"];
    NSString *name = dictionary[@"fullName"];
    NSString *fullName = dictionary[@"fullName"];
    
    return [self initWithID:cameraID.intValue roverID:roverID.intValue name:name fullName:fullName];
}

@end
