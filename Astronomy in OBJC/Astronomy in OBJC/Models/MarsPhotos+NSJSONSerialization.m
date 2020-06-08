//
//  MarsPhotos+NSJSONSerialization.m
//  Astronomy-in-OBJC
//
//  Created by Sal B Amer on 6/4/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

#import "MarsPhotos+NSJSONSerialization.h"

@implementation MarsPhotos (NSJSONSerialization)

- (instancetype) initwithMarsPhotosDictionary:(NSDictionary *)dictionary {
  NSNumber *sol = dictionary[@"sol"];
  NSString *imgSrc = dictionary[@"img_src"];
  NSURL *imageURL = [NSURL URLWithString:imgSrc];
  NSString *earthDate = dictionary[@"earch_date"];
  NSDictionary *camera = dictionary[@"camera"];
  NSNumber *roverID = camera[@"rover_id"];
  NSString *cameraName = camera[@"name"];
  MarsPhotos *photo = [[MarsPhotos alloc] initWithIdentification:(NSNumber *) roverID
                                                           sol:(NSNumber *) sol
                                                        camera:(NSString *) cameraName
                                                     earthDate:(NSString *) earthDate
                                                      imageURL:(NSURL *) imageURL];
  return photo;
}

@end
