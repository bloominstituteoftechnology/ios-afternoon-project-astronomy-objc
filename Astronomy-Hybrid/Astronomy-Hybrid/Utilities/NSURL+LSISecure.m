//
//  NSURL+LSISecure.m
//  Astronomy-Hybrid
//
//  Created by Isaac Lyons on 12/17/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

#import "NSURL+LSISecure.h"

@implementation NSURL (LSISecure)

- (NSURL *)usingHTTPS {
    NSURLComponents *components = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:YES];
    if (components) {
        [components setScheme:@"https"];
        return [components URL];
    }
    
    return nil;
}

@end
