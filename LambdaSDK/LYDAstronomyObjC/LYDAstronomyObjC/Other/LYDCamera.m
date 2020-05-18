//
//  LYDCamera.m
//  LYDAstronomyObjC
//
//  Created by Lydia Zhang on 5/18/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

#import "LYDCamera.h"

@implementation LYDCamera

- (instancetype)initWithDictionary: (NSDictionary *)cameraDictionary{
    self = [super init];
    if (self){
        _identifier = [cameraDictionary[@"id"] intValue];
        _fullName = cameraDictionary[@"fullName"];
        _roverID = [cameraDictionary[@"rover_id"] intValue];
        _name = cameraDictionary[@"name"];
    }
    return self;
}

@end
