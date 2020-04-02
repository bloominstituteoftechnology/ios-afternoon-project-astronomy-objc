//
//  NSURL+LSISecure.h
//  Astronomy-Hybrid
//
//  Created by Isaac Lyons on 12/17/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (LSISecure)

- (NSURL *_Nullable)usingHTTPS;

@end
