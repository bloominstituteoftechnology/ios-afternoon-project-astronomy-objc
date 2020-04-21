//
//  DMORover.m
//  AstronomyObjC
//
//  Created by morse on 1/26/20.
//  Copyright © 2020 morse. All rights reserved.
//

#import "DMORover.h"
#import "DMOSolDescription.h"

@implementation DMORover

- (instancetype)initWithName:(NSString *)name solDescriptions:(NSArray<DMOSolDescription *> *)sols {
    self = [super init];
    if (self) {
        _name = [name copy];
        _solDescriptions = [sols copy];
    }
    return self;
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    
    NSArray *solDictionaries = dictionary[@"photos"];
    NSMutableArray *sols = [[NSMutableArray alloc] init];
    
    for (NSDictionary *solDictionary in solDictionaries) {
        DMOSolDescription *solDescription = [[DMOSolDescription alloc] initWithDictionary:solDictionary];
        [sols addObject:solDescription];
    }
    return [self initWithName:name solDescriptions:[sols copy]];
}

@end
