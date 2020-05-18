//
//  SSSPhotoManifest.m
//  Astronomy
//
//  Created by Shawn Gee on 5/18/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import "SSSPhotoManifest.h"

@implementation SSSPhotoManifest

- (NSDictionary *)codingKeys {
    return @{
        CODING_KEY(sols): @"photos",
    };
}

@end
