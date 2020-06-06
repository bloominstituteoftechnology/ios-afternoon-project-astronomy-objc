//
//  CATCamera.m
//  Astronomy
//
//  Created by Jessie Ann Griffin on 6/3/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

#import "CATCamera.h"

@implementation CATCamera
- (instancetype)initWithID:(int)anIdentifier
                      name:(NSString *)aName
                   roverID:(int)roverID
                  fullName:(NSString *)aFullName
{
    if (self = [super init]) {
        _identifier = anIdentifier;
        _name = aName;
        _roverID = roverID;
        _fullName = aFullName;
    }
    return self;
}

//- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary
//{
//
//}

@end
