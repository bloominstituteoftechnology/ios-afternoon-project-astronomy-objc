//
//  SolArrayResult.m
//  AstronomyObjC
//
//  Created by Nick Nguyen on 4/21/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

#import "SolArrayResult.h"
#import "Sol.h"
#import "SolCamera.h"


@implementation SolArrayResult

- (instancetype)initWithSols:(NSArray<Sol *> *)sols {
    self = [super init];
    if (self) {
        _solArray = sols;
    }
    return self;
}


- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSArray *photos = dictionary[@"photos"];
    NSMutableArray *sols = [[NSMutableArray alloc] init];
    for (NSDictionary *solDict in photos) {
        Sol *sol = [[Sol alloc]initWithDictionary:solDict];
        if (sol) {
            [sols addObject:sol];
        } else {
           NSLog(@"Unable to parse quake dictionary: %@", solDict);
        }
    }
    self = [self initWithSols:sols];
    return self;
}



@end
