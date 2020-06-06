//
//  LSISolDescription.m
//  Astronomy
//
//  Created by David Wright on 6/3/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

#import "LSISolDescription.h"

@implementation LSISolDescription

- (instancetype)initWithSol:(int)sol
                totalPhotos:(int)totalPhotos
                    cameras:(NSArray<NSString *> *)cameras
{
    if (self = [super init]) {
        _sol = sol;
        _totalPhotos = totalPhotos;
        _cameras = cameras.copy;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSNumber *sol = [dictionary objectForKey:@"sol"];
    if (![sol isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *totalPhotos = [dictionary objectForKey:@"total_photos"];
    if (![totalPhotos isKindOfClass:[NSNumber class]]) return nil;
    
    NSArray *cameras = [dictionary objectForKey:@"cameras"];
    if (![cameras isKindOfClass:[NSArray class]]) return nil;
    
    return [self initWithSol:sol.intValue
                 totalPhotos:totalPhotos.intValue
                     cameras:cameras];
}

@end
