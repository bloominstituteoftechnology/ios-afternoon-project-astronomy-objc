//
//  SSSMarsCamera.m
//  Astronomy
//
//  Created by Shawn Gee on 5/18/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import "SSSMarsCamera.h"

@implementation SSSMarsCamera
    
- (NSDictionary *)codingKeys {
    return @{
        CODING_KEY(name): @"full_name",
        CODING_KEY(roverID): @"rover_id",
    };
}

@end
