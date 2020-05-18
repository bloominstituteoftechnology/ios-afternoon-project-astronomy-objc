//
//  TMCMarsRoverCamera.m
//  AstronomyObjC
//
//  Created by Christopher Devito on 5/18/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import "TMCMarsRoverCamera.h"

@implementation TMCMarsRoverCamera
-(instancetype) initWithid:(NSNumber *)id name:(NSString *) Name roverID:(NSNumber *) RoverID fullName:(NSString *) FullName {
    _id = id;
    _name = Name;
    _roverId = RoverID;
    _fullName = FullName;
    return self;
}
@end
