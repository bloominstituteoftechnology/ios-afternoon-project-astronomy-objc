//
//  SSSMarsSol.m
//  Astronomy
//
//  Created by Shawn Gee on 5/18/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import "SSSMarsSol.h"

@implementation SSSMarsSol

- (NSDictionary *)codingKeys {
    return @{
        CODING_KEY(solNumber): @"sol",
        CODING_KEY(numPhotos): @"total_photos",
    };
}

@end
