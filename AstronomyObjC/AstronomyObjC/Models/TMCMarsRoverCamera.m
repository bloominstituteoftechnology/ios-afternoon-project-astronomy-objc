//
//  TMCMarsRoverCamera.m
//  AstronomyObjC
//
//  Created by Christopher Devito on 5/18/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import "TMCMarsRoverCamera.h"

@implementation TMCMarsRoverCamera
-(instancetype) initWithIdentity:(NSNumber *)identity
                            name:(NSString *) name
                         roverID:(NSNumber *) roverID
                        fullName:(NSString *) fullName {
    
    self = [super init];
    if (self) {
    _identity = identity;
    _name = name;
    _roverId = roverID;
    _fullName = fullName;
    }
    return self;
}
@end
