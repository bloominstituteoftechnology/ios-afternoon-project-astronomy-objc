//
//  LSIMarsRover.m
//  Astronomy-Hybrid
//
//  Created by Isaac Lyons on 12/16/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

#import "LSIMarsRover.h"
#import "LSISol.h"

@implementation LSIMarsRover

- (instancetype)initWithName:(NSString *)name
                        sols:(NSArray<LSISol *> *)sols{
    self = [super init];
    if (self) {
        _name = [name copy];
        _sols = [sols copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    NSArray *photos = dictionary[@"photos"];
    
    NSMutableArray<LSISol *> *sols = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in photos) {
        LSISol *sol = [[LSISol alloc] initWithDictionary:dictionary];
        if (sol) {
            [sols addObject:sol];
        }
    }
    
    if (!name || !sols) {
        return nil;
    }
    
    return [self initWithName:name sols:sols];
}

@end
