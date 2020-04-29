//
//  NSURL+SecureHTTP.m
//  Astronomy-ObSwiftive-c
//
//  Created by Craig Swanson on 4/22/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import "NSURL+SecureHTTP.h"

@implementation NSURL (SecureHTTP)

+ (NSURL *)convertHTTPtoHTTPS:(NSURL *)inputURL {
    NSURLComponents *inputURLComponents = [[NSURLComponents alloc] initWithURL:inputURL resolvingAgainstBaseURL:YES];
    inputURLComponents.scheme = @"https";
    NSURL *newURL = inputURLComponents.URL;
    return newURL;
}

@end
