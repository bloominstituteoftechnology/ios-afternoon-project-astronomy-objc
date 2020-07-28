//
//  LSISolDescription.m
//  AstronomyOBJc
//
//  Created by Kelson Hartle on 7/25/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import "LSISolDetails.h"

@implementation LSISolDetails


-(instancetype)initWithSolNumber:(NSNumber *)solNumber
                     totalPhotos:(NSNumber *)totalPhotos
                         cameras:(NSArray<NSString *>*)cameras {
    
    self = [super init];
    if (self) {
        _solNumber = solNumber;
        _totalPhotos = totalPhotos;
        _cameras = [cameras copy];
        
        
    }
    return self;
    
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    NSNumber *solNumber = dictionary[@"sol"];
    NSNumber *totalPhotos = dictionary[@"total_photos"];
    NSArray *cameras = dictionary[@"cameras"];
    NSMutableArray *cameraArray = [NSMutableArray alloc];
    
    for (NSString *camera in cameras) {
        if (camera) {
            [cameraArray addObject:camera];
        }
    }
    
    self = [self initWithSolNumber:solNumber totalPhotos:totalPhotos cameras:cameraArray];
    return self;
}





@end
