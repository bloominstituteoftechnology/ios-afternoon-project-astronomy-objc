//
//  MBMSolInfo.m
//  Astronomy-Objc
//
//  Created by Michael on 3/23/20.
//  Copyright © 2020 Michael. All rights reserved.
//

#import "MBMSolInfo.h"

@implementation MBMSolInfo

- (instancetype)initWithSol:(int)sol
                totalPhotos:(int)totalPhotos
                    cameras:(NSArray<NSString *> *)cameras {
    
    self = [super init];
    if (self) {
        _sol = sol;
        _totalPhotos = totalPhotos;
        _cameras = cameras;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
        
    NSNumber *sol = dictionary[@"sol"];
    NSNumber *totalPhotos = dictionary[@"total_photos"];
    NSArray *cameras = dictionary[@"cameras"];
        
    self = [self initWithSol:sol.intValue
                 totalPhotos:totalPhotos.intValue
                     cameras:cameras];
    
    return self;
}

@end
