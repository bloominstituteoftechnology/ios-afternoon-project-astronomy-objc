//
//  SolCamera.m
//  AstronomyObjC
//
//  Created by Nick Nguyen on 4/21/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

#import "SolCamera.h"

@implementation SolCamera
- (instancetype) initWithName:(NSString *)name fullName:(NSString *)fullName {
    self = [super init];
    if (self) {
        _name = [name copy];
        _fullName = [fullName copy];
    }
    return self;
}

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    NSString *fullName = dictionary[@"full_name"];
    self = [self initWithName:name fullName:fullName];
    return self;
}@end
