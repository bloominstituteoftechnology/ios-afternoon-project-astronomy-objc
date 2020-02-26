//
//  CARMarsCamera.m
//  CARAstronomy
//
//  Created by Chad Rutherford on 2/24/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import "CARMarsCamera.h"

@implementation CARMarsCamera

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
}
@end
