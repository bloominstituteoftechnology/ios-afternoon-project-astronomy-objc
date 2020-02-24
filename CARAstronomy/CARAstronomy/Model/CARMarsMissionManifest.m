//
//  CARMarsMissionManifest.m
//  CARAstronomy
//
//  Created by Chad Rutherford on 2/24/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import "CARMarsMissionManifest.h"

@interface CARMarsMissionManifest ()

@property (nonatomic, nonnull) NSMutableArray *internalSols;

@end

@implementation CARMarsMissionManifest

- (instancetype) init {
    self = [super init];
    if (self) {
        _internalSols = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype) initWitihDictionary:(NSDictionary *)dictionary {
    NSDictionary *manifest = dictionary[@"photo_manifest"];
    NSArray *photos = manifest[@"photos"];
    NSMutableArray *sols = [[NSMutableArray alloc] init];
    for (NSDictionary *solDictionary in photos) {
        NSNumber *sol = solDictionary[@"sol"];
        [sols addObject:sol];
    }
    self.internalSols = sols;
    return self;
}

- (NSArray *)sols {
    return [_internalSols copy];
}

@end
