//
//  VVSCamera.m
//  Astronomy-Hybrid
//
//  Created by Vici Shaweddy on 2/12/20.
//  Copyright © 2020 Vici Shaweddy. All rights reserved.
//

#import "VVSCamera.h"
#import "Astronomy_Hybrid-Swift.h"

@implementation VVSCamera

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _id = [dictionary[@"id"] integerValue];
        _name = dictionary[@"name"];
        _roverId = [dictionary[@"rover_id"] integerValue];
        _fullName = dictionary[@"full_name"];
    }
    return self;
}

@end
