//
//  TMCMarsPhotoReference+NSJSONSerialization.m
//  AstronomyObjC
//
//  Created by Christopher Devito on 5/18/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import "TMCMarsPhotoReference+NSJSONSerialization.h"

@implementation TMCMarsPhotoReference (NSJSONSerialization)

- (instancetype) initWithMarsPhotoDictionary:(NSDictionary *)dictionary {
        NSNumber *sol = dictionary[@"sol"];
        NSString *imgSrc = dictionary[@"img_src"];
        NSString *earthDate = dictionary[@"earth_date"];
        NSDictionary *camera = dictionary[@"camera"];
        NSNumber *roverID = camera[@"rover_id"];
        NSString *cameraName = camera[@"name"];
        TMCMarsPhotoReference *photo = [[TMCMarsPhotoReference alloc] initWithIdentification:(NSNumber *)roverID
                                                                                         sol:(NSNumber *) sol
                                                                                      camera:(TMCMarsRoverCamera *) cameraName
                                                                                   earthDate:(NSDate *) earthDate
                                                                                    imageURL:(NSURL *) imgSrc];


    return photo;
}

@end
