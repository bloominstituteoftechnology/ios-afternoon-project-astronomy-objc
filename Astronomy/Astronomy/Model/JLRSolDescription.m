//
//  JLRSolDescription.m
//  Astronomy
//
//  Created by Jesse Ruiz on 12/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

#import "JLRSolDescription.h"

@implementation JLRSolDescription

- (nonnull instancetype)initWithCamera:(nonnull NSArray<NSString *> *)cameras
                                   sol:(double)sol
                           totalPhotos:(double)totalPhotos
{
    self = [super init];
    if (self) {
        _cameras = [cameras copy];
        _sol = sol;
        _totalPhotos = totalPhotos;
    }
    return self;
}

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)solDescriptionDictionary
{
    NSArray<NSString *> *cameras = solDescriptionDictionary[@"cameras"];
    NSString *solString = solDescriptionDictionary[@"sol"];
    double sol = [solString doubleValue];
    NSString *totalPhotosString = solDescriptionDictionary[@"total_photos"];
    double totalPhotos = [totalPhotosString doubleValue];
    
    if (!cameras || !solString || !totalPhotosString) {
        return nil;
    }
    return [self initWithCamera:cameras sol:sol totalPhotos:totalPhotos];
}

@end
