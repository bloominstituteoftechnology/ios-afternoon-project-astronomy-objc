//
//  JDKMarsRover.m
//  Astronomy-ObjC
//
//  Created by John Kouris on 2/12/20.
//  Copyright © 2020 John Kouris. All rights reserved.
//

#import "JDKMarsRover.h"
#import "JDKSolDescription.h"

@implementation JDKMarsRover

- (instancetype)initWithName:(NSString *)name sols:(NSArray<JDKSolDescription *> *)sols
{
    if (self = [super init]) {
        _name = [name copy];
        _sols = [sols copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    NSArray *photos = dictionary[@"photos"];
    
    NSMutableArray<JDKSolDescription *> *sols = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in photos) {
        JDKSolDescription *sol = [[JDKSolDescription alloc] initWithDictionary:dictionary];
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
