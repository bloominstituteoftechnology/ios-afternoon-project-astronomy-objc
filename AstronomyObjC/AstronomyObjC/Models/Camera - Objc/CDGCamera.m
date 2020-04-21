//
//  CDGCamera.m
//  AstronomyObjC
//
//  Created by Chris Gonzales on 4/21/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

#import "CDGCamera.h"

@implementation CDGCamera

- (instancetype)initWithIdentifier:(NSInteger)identifier
                              name:(NSString *)name
                           roverID:(NSInteger)roverID
                          fullName:(NSString *)fullname {
    self = [super init];
       if (self) {
           _identifier = identifier;
           _name = [name copy];
           _roverID = roverID;
           _fullName = [fullname copy];
       }
       return self;
}



@end
