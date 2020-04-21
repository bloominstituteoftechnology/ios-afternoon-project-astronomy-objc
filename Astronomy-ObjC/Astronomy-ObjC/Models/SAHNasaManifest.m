//
//  SAHNasaManifest.m
//  Astronomy-ObjC
//
//  Created by scott harris on 4/20/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

#import "SAHNasaManifest.h"
#import "SAHSol.h"

@implementation SAHNasaManifest

- (instancetype)initWithName:(NSString *)name maxSol:(int)maxSol sols:(NSArray<SAHSol *> *)sols {
        self = [super init];
        if (self) {
            _name = name;
            _maxSol = maxSol;
            _sols = sols;
    
        }
        return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    NSNumber *maxSolNumber = dictionary[@"max_sol"];
    NSArray<NSDictionary *> *solDictionarys = dictionary[@"photos"];
    
    NSMutableArray<SAHSol *> *sols = [[NSMutableArray alloc] init];
    for (NSDictionary *solDictionary in solDictionarys) {
        SAHSol *sol = [[SAHSol alloc] initWithDictionary:solDictionary];
        [sols addObject:sol];
    }
    
    self = [self initWithName:name maxSol:maxSolNumber.intValue sols:sols];
    
    return self;
    
}

@end
