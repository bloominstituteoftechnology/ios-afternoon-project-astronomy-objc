//
//  TLManifest.m
//  Astronomy-Interoperability
//
//  Created by Christian Lorenzo on 6/3/20.
//  Copyright © 2020 Christian Lorenzo. All rights reserved.
//

#import "TLManifest.h"

@implementation TLManifest

- (instancetype)initWithSolID:(int)solID photoCount:(int)photoCount cameras:(NSArray<NSString *> *)cameras {
    
    self = [super init];
    if (self) {
        _solID = solID;
        _photoCount = photoCount;
        _cameras = [cameras copy];
    }
    
    return self;
}

@end
