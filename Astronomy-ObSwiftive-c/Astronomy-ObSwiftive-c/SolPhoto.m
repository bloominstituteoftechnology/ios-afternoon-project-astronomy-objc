//
//  SolPhoto.m
//  Astronomy-ObSwiftive-c
//
//  Created by Craig Swanson on 4/20/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import "SolPhoto.h"

@implementation SolPhoto

-(instancetype)initWithSol:(int)sol totalPhotos:(int)total_photos {
    if (self = [self init]) {
        _sol = sol;
        _total_photos = total_photos;
    }
    return self;
}

-(instancetype)initWithSols:(NSArray<SolPhoto *> *)solPhotos {
    if (self = [super init]) {
        _solPhotos = solPhotos;
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSArray *solPhotos = dictionary[@"photos"];
    NSMutableArray *solPhotosArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in solPhotos) {
        NSNumber *sol = dictionary[@"sol"];
        NSNumber *total_photos = dictionary[@"total_photos"];
        
        if ([sol isKindOfClass:[NSNull class]]) {
            sol = nil;
        }
        if ([total_photos isKindOfClass:[NSNull class]]) {
            total_photos = nil;
        }
        
        SolPhoto *newSol = [[SolPhoto alloc] initWithSol:sol.intValue totalPhotos:total_photos.intValue];
        
        [solPhotosArray addObject:newSol];
    }
    self = [self initWithSols:solPhotosArray];
    return self;
}

@end

/*
 {
 "photo_manifest": {
 "name": "Curiosity",
 "landing_date": "2012-08-06",
 "launch_date": "2011-11-26",
 "status": "active",
 "max_sol": 2736,
 "max_date": "2020-04-17",
 "total_photos": 416179,
 "photos": [
 {
 "sol": 0,
 "earth_date": "2012-08-06",
 "total_photos": 3702,
 "cameras": [
 "CHEMCAM",
 "FHAZ",
 "MARDI",
 "RHAZ"
 ]
 },
 */
