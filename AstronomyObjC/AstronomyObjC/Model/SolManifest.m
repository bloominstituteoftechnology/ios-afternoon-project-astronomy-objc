//
//  SolManifest.m
//  AstronomyObjC
//
//  Created by Nick Nguyen on 4/22/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

#import "SolManifest.h"

@interface SolManifest ()

@property (nonatomic, nonnull) NSMutableArray *internalSols;

@end




@implementation SolManifest

- (instancetype)init {
    self = [super init];
    if (self) {
        _internalSols = [[NSMutableArray alloc]init];
    }
    return self;
}

- (instancetype _Nonnull)initWithDictionary:(NSDictionary *_Nonnull)dictionary {
    NSDictionary *photoManifest = dictionary[@"photo_manifest"];
    NSArray *photos = photoManifest[@"photos"];
    NSMutableArray *sols = [[NSMutableArray alloc]init];
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
