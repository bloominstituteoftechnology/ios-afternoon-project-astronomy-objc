//
//  LSIMarsRover.m
//  Astronomy-Hybrid
//
//  Created by Isaac Lyons on 12/16/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

#import "LSIMarsRover.h"

@implementation LSIMarsRover

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = [name copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    
    if (!name) {
        return nil;
    }
    
    return [self initWithName:name];
}

@end
