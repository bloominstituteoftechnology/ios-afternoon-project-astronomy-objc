//
//  NSObject+NSJSONSerialization.m
//  Astronomy-in-OBJC
//
//  Created by Sal B Amer on 6/4/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

#import "NSObject+NSJSONSerialization.h"
#import "MarsPhotos.h"
#import "MarsPhotos+NSJSONSerialization.h"

@implementation NSObject (NSJSONSerialization)

- (instancetype) initArrayWithDictionary:(NSDictionary *)dictionary
{
  self = [self init];
  NSMutableArray *photoArray = [[NSMutableArray alloc] init];
  NSArray *photos = dictionary[@"photos"];
  //loop through the photos
  for (int i = 0; i < photos.count; i++) {
    MarsPhotos *photo = [[MarsPhotos alloc]
                         initwithMarsPhotosDictionary:photos[i]];
    [photoArray addObject:photo];
  }
  return photoArray;
}

@end
