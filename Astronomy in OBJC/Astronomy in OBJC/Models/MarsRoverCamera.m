//
//  MarsRoverCamera.m
//  Astronomy-in-OBJC
//
//  Created by Sal B Amer on 6/4/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

#import "MarsRoverCamera.h"

@implementation MarsRoverCamera

-(instancetype) initWithIdentity:(NSNumber *)identity
                            name:(NSString *)name
                         roverId:(NSNumber *)roverId
                        fullName:(NSString *)fullName
{
  self = [super init];
  if (self) {
    _identity = identity;
    _name = name;
    _roverId = roverId;
    fullName = fullName;
  }
  return self;
}

@end
