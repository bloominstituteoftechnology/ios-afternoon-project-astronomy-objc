//
//  LSICamera.m
//  AstronomyOBJc
//
//  Created by Kelson Hartle on 7/25/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import "LSIMarsCamera.h"

@implementation LSIMarsCamera

-(instancetype)initWithName:(NSString *)name
                 identifier:(NSNumber *)identifier
                    roverID:(NSNumber *)roverID {
    
    self = [super init];
    if (self) {
        _name = [ name copy ];
        _identifier = identifier;
        _roverID = roverID;
    }
    return self;
}


-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    NSNumber *identifer = dictionary[@"id"];
    NSNumber *roverID = dictionary[@"rover_id"];
    
    
    self = [self initWithName:name identifier:identifer roverID:roverID];
    return self;
}


@end
