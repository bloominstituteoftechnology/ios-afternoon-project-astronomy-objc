//
//  Camera.m
//  Obj-C-Astronomy
//
//  Created by Patrick Millet on 6/16/20.
//  Copyright © 2020 PatrickMillet79. All rights reserved.
//

#import "PDMCamera.h"

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
