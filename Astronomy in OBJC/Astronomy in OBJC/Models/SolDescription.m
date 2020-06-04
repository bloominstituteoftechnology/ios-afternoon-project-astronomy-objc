//
//  SolDescription.m
//  Astronomy in OBJC
//
//  Created by Sal B Amer on 6/4/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

#import "SolDescription.h"

@implementation SolDescription

-(instancetype)initWithSol:(NSNumber *)sol
               totalPhotos:(NSNumber *)totalPhotos
                   cameras:(NSMutableArray *)cameras
{
  self = [super init];
  if (self) {
    _sol = sol;
    _totalPhotos = totalPhotos;
    _cameras = cameras;
  }
  return self;
}

@end
