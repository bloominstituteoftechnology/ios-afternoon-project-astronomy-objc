//
//  JLCCamera.m
//  iOS9-Astronomy
//
//  Created by Jake Connerly on 11/12/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

#import "JLCCamera.h"

@implementation JLCCamera

- (instancetype)initWithName:(NSString *)name fullName:(NSString *)fullName {
    self = [super init];
    if (self) {
        _name = name;
        _fullName = fullName;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)cameraDictionary {
    NSString *name = cameraDictionary[@"name"];
    NSString *fullName = cameraDictionary[@"full_name"];
    
    return [self initWithName:name fullName:fullName];
}

@end
