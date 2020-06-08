//
//  MarsPhotos.m
//  Astronomy-in-OBJC
//
//  Created by Sal B Amer on 6/4/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

#import "MarsPhotos.h"

@implementation MarsPhotos
-(instancetype) initWithIdentification:(NSNumber *)identification
                                   sol:(NSNumber *)sol
                                camera:(NSString *)camera
                             earthDate:(NSString *)earthDate
                              imageURL:(NSURL *)imageURL
{
  self = [super init];
  if (self) {
    _identification = identification;
    _sol = sol;
    _camera = camera;
    _earthDate = earthDate;
    _imageURL = imageURL;
  }
  return self;
}

@end
