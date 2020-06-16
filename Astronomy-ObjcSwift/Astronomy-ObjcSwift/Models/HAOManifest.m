//
//  HAOManifest.m
//  Astronomy-ObjcSwift
//
//  Created by Hunter Oppel on 6/16/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

#import "HAOManifest.h"

@implementation HAOManifest

- (instancetype)initWithSolManifest:(NSArray<NSNumber *> *)solManifest
{
    self = [super init];
    if (self) {
        _solManifest = solManifest;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSMutableArray<NSNumber *> *sols = [[NSMutableArray alloc] init];
    
    NSDictionary *photoManifestDictionary = dictionary[@"photo_manifest"];
    NSArray *photosArray = photoManifestDictionary[@"photos"];
    
    for (NSDictionary *dictionary in photosArray) {
        [sols addObject:dictionary[@"sol"]];
    }
    
    self = [self initWithSolManifest:sols];
    return self;
}

@end
