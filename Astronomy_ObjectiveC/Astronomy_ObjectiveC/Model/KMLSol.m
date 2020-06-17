//
//  KMLSol.m
//  Astronomy_ObjectiveC
//
//  Created by Kenny on 6/15/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

#import "KMLSol.h"

@implementation KMLSol

int privateSolID;
NSArray *privatePhotos;

- (int)solID {
    return privateSolID;
}

- (NSArray *)photos {
    return [privatePhotos copy];
}

- (instancetype) initWithSolID:(int)solID photos:(NSArray *)photoURLs
{
    self = [super init];
    if (self) {
        privateSolID = solID;
        privatePhotos = [photoURLs copy];
    }
    return self;
}

@end

