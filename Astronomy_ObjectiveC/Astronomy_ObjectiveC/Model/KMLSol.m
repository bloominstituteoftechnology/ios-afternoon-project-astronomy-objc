//
//  KMLSol.m
//  Astronomy_ObjectiveC
//
//  Created by Kenny on 6/15/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

#import "KMLSol.h"

@implementation KMLSol

- (instancetype) initWithSolID:(int)solID photoURLs:(NSArray *)photoURLs
{
    self = [super init];
    if (self) {
        _solID = solID;
        _photoURLs = photoURLs;
    }
    return self;
}

@end

