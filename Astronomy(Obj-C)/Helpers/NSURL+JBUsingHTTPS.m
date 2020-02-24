//
//  NSURL+JBUsingHTTPS.m
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-27.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import "NSURL+JBUsingHTTPS.h"


@implementation NSURL (JBUsingHTTPS)

- (NSURL *)urlUsingHTTPS
{
    NSURLComponents *components = [NSURLComponents componentsWithURL:self
                                             resolvingAgainstBaseURL:YES];
    [components setScheme:@"https"];
    return components.URL;
}

@end
