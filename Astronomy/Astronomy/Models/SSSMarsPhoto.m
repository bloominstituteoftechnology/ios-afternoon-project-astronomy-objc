//
//  SSSMarsPhoto.m
//  Astronomy
//
//  Created by Shawn Gee on 5/18/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import "SSSMarsPhoto.h"

@implementation SSSMarsPhoto

- (NSDictionary *)codingKeys {
    return @{
        CODING_KEY(solNumber): @"sol",
        CODING_KEY(earthDate): @"earth_date",
        CODING_KEY(imageURLString): @"img_src",
        CODING_KEY(camera): @"camera",
    };
}

@end
