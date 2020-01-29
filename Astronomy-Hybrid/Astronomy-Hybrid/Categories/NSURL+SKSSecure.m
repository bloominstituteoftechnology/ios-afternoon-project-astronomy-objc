//
//  NSURL+SKSSecure.m
//  Astronomy-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "NSURL+SKSSecure.h"

@implementation NSURL (SKSSecure)

- (NSURL *)usingHTTPS {
    NSURLComponents *components = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:true];
    [components setScheme:@"https"];
    return components.URL;
}

@end
