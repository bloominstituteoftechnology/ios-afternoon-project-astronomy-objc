//
//  NPTMarsMissionManifest.m
//  AstronomyObjC
//
//  Created by Nick Nguyen on 4/21/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

#import "NPTMarsMissionManifest.h"

@interface NPTMarsMissionManifest ()
@property (nonatomic, nonnull) NSMutableArray *internalSols;

@end


@implementation NPTMarsMissionManifest

- (instancetype)init {
    self = [super init];
    if (self) {
        _internalSols = [[NSMutableArray alloc]init];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
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
