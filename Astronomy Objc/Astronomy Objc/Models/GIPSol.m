//
//  GIPSol.m
//  Astronomy Objc
//
//  Created by Gi Pyo Kim on 12/16/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

#import "GIPSol.h"

@implementation GIPSol

- (nonnull instancetype)initWithSol:(int)sol earthDate:(nonnull NSString *)earthDate totalPhotos:(int)totalPhotos {
    self = [super init];
    if (self) {
        _sol = sol;
        _earthDate = earthDate;
        _totalPhotos = totalPhotos;
    }
    return self;
}


- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary {
    NSNumber *solNumber = dictionary[@"sol"];
    int sol = [solNumber intValue];
    
    NSString *date = dictionary[@"earth_date"];
    
    NSNumber *photoNumber = dictionary[@"total_photos"];
    int photos = [photoNumber intValue];
    
    if (!sol || !date || !photos) {
        return nil;
    }
    
    return [self initWithSol:sol earthDate:date totalPhotos:photos];
}
@end
