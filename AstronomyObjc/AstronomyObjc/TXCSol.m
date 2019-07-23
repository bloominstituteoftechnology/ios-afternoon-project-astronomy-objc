//
//  TXCSol.m
//  AstronomyObjc
//
//  Created by Thomas Cacciatore on 7/23/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

#import "TXCSol.h"

@implementation TXCSol

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _solNumber = [dictionary[@"photos"] intValue];
        _totalPhotos = [dictionary[@"photos"][@"total_photos"] intValue];
    }
    return self;
}

@end
