//
//  JLRCamera.m
//  Astronomy
//
//  Created by Jesse Ruiz on 12/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

#import "JLRCamera.h"

@implementation JLRCamera

- (nonnull instancetype)initWithName:(nonnull NSString *)name
                      identification:(double)identification
                             roverId:(double)roverId
                            fullName:(nonnull NSString *)fullName
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _identification = identification;
        _roverId = roverId;
        _fullName = [fullName copy];
    }
    return self;
}

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    NSString *identificationString = dictionary[@"identification"];
    double identification = [identificationString doubleValue];
    NSString *roverIdString = dictionary[@"rover_id"];
    double roverId = [roverIdString doubleValue];
    NSString *fullName = dictionary[@"full_name"];
    
    if (!name || !identificationString || !roverIdString || !fullName) {
        return nil;
    }
    
    return [self initWithName:name identification:identification roverId:roverId fullName:fullName];
}

@end
