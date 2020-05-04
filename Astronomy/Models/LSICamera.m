//
//  LSICamera.m
//  Astronomy
//
//  Created by Andrew R Madsen on 11/28/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import "LSICamera.h"

@implementation LSICamera

- (instancetype)initWithIdentifier:(NSInteger)identifier name:(NSString *)name roverId:(NSInteger)roverId fullName:(NSString *)fullName
{
    self = [super init];
    if (self) {
        _identifier = identifier;
        _name = [name copy];
        _roverId = roverId;
        _fullName = [fullName copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSNumber *identifier = dictionary[@"id"];
    NSString *name = dictionary[@"name"];
    NSNumber *roverId = dictionary[@"rover_id"];
    NSString *fullName = dictionary[@"full_name"];
    if (!identifier || !name || !roverId || !fullName) { return nil; }

    return [self initWithIdentifier:identifier.integerValue name:name roverId:roverId.integerValue fullName:fullName];

}

@end
