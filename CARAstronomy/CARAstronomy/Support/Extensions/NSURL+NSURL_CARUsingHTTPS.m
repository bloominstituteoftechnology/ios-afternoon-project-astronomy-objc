//
//  NSURL+NSURL_CARUsingHTTPS.m
//  CARAstronomy
//
//  Created by Chad Rutherford on 2/25/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import "NSURL+NSURL_CARUsingHTTPS.h"

@implementation NSURL (CARUsingHTTPS)

- (NSURL *)urlUsingHTTPS {
    NSURLComponents *components = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:YES];
    [components setScheme:@"https"];
    return components.URL;
}

@end
