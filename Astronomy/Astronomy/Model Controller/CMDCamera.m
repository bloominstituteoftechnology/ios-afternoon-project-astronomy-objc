//
//  CMDCamera.m
//  Astronomy
//
//  Created by Chris Dobek on 6/17/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

#import "CMDCamera.h"

@implementation CMDCamera

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
