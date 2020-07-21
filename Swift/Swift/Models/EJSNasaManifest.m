//
//  EJSNasaManifest.m
//  Swift
//
//  Created by Enzo Jimenez-Soto on 7/21/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

#import "EJSNasaManifest.h"
#import "EJSSol.h"

@implementation EJSNasaManifest
- (instancetype)initWithName:(NSString *)name maxSol:(int)maxSol sols:(NSArray<EJSSol *> *)sols {
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
    
    NSMutableArray<EJSSol *> *sols = [[NSMutableArray alloc] init];
    for (NSDictionary *solDictionary in solDictionarys) {
        EJSSol *sol = [[EJSSol alloc] initWithDictionary:solDictionary];
        [sols addObject:sol];
    }
    
    self = [self initWithName:name maxSol:maxSolNumber.intValue sols:sols];
    
    return self;
    
}

@end
