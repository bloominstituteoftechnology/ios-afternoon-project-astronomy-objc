//
//  EGCCamera.m
//  AstronomyObjectiveC
//
//  Created by Enrique Gongora on 4/21/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

#import "EGCCamera.h"

@implementation EGCCamera

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
