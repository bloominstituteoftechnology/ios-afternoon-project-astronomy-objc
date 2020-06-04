//
//  NSURL+UsingHTTPS.m
//  Astronomy-in-OBJC
//
//  Created by Sal B Amer on 6/4/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

#import "NSURL+UsingHTTPS.h"

@implementation NSURL (UsingHTTPS)

- (NSURL *) usingHTTPS {
  NSURLComponents *components = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:YES];
  components.scheme = @"https";
  return components.URL;
}

@end
