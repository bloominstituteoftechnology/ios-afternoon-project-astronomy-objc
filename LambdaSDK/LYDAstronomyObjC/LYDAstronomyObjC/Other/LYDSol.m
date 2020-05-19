//
//  LYDSol.m
//  LYDAstronomyObjC
//
//  Created by Lydia Zhang on 5/18/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

#import "LYDSol.h"

@implementation LYDSol

- (instancetype)initWithSolDictionary: (NSDictionary *)solDictionary{
    self = [super init];
    if (self) {
        _totalPhotos = [solDictionary[@"total_photos"] intValue];
        _cameraArray = solDictionary[@"cameras"];
        _sol = [solDictionary[@"sol"] intValue];
    }
    return self;
}

@end
