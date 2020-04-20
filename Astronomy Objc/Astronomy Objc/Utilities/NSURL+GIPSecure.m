//
//  NSURL+GIPSecure.m
//  Astronomy Objc
//
//  Created by Gi Pyo Kim on 12/17/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

#import "NSURL+GIPSecure.h"

@implementation NSURL (GIPSecure)

- (nullable NSURL *)usingHTTPS {
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:self resolvingAgainstBaseURL:YES];
    
    if (!components) {
        return nil;
    } else {
        [components setScheme:@"https"];
        return components.URL;
    }    
}

@end
