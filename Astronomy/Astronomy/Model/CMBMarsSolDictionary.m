//
//  CMBMarsSolDictionary.m
//  Astronomy
//
//  Created by Craig Belinfante on 12/6/20.
//

#import "CMBMarsSol.h"
#import "CMBMarsSolDictionary.h"

@implementation CMBMarsSolDictionary

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (!self) { return nil; }
    
    NSArray<NSDictionary *> *solDicts = dictionary[@"photos"];
    NSMutableArray *sols = [[NSMutableArray alloc] init];
    
    for (NSDictionary *solDict in solDicts) {
        CMBMarsSol *sol = [[CMBMarsSol alloc] initWithDictionary:solDict];
        [sols addObject:sol];
    }
    
    _sols = [sols copy];
    
    return self;
}

@end
