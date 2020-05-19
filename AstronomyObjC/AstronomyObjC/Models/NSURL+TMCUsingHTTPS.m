//
//  NSURL+TMCUsingHTTPS.m
//  AstronomyObjC
//
//  Created by Christopher Devito on 5/19/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import "NSURL+TMCUsingHTTPS.h"

@implementation NSURL (TMCUsingHTTPS)
-(NSURL *)usingHTTPS {
    NSURLComponents *components = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:YES];
    components.scheme = @"https";
    return components.URL;
}
@end
