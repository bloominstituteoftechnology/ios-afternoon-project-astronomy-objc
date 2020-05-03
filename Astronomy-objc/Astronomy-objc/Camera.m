//
//  Camera.m
//  Astronomy-objc
//
//  Created by Dillon P on 4/26/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

#import "Camera.h"

@implementation Camera

- (instancetype)initWithIdentifier:(int)identifier
                              name:(NSString *)name
                           roverID:(int)roverID
                          fullName:(NSString *)fullName
{
    if (self = [super init]) {
        _identifier = identifier;
        _name = name;
        _roverID = roverID;
        _fullName = fullName;
    }
    return self;
}

@end
