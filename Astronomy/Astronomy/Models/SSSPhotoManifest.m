//
//  SSSPhotoManifest.m
//  Astronomy
//
//  Created by Shawn Gee on 5/18/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import "SSSPhotoManifest.h"
#import "SSSMarsSol.h"

@implementation SSSPhotoManifest

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (!self) { return nil; }
    
    NSArray<NSDictionary *> *solDicts = dictionary[@"photos"];
    NSMutableArray *sols = [[NSMutableArray alloc] init];
    
    for (NSDictionary *solDict in solDicts) {
        SSSMarsSol *sol = [[SSSMarsSol alloc] initWithDictionary:solDict];
        [sols addObject:sol];
    }
    
    _sols = [sols copy];
    
    return self;
}

@end
