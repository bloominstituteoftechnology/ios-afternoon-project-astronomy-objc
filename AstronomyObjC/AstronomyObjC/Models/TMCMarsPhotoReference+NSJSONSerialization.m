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
        NSURL *imageURL = [NSURL URLWithString:imgSrc];
        NSString *earthDate = dictionary[@"earth_date"];
        NSDictionary *camera = dictionary[@"camera"];
        NSNumber *roverID = camera[@"rover_id"];
        NSString *cameraName = camera[@"name"];
        TMCMarsPhotoReference *photo = [[TMCMarsPhotoReference alloc] initWithIdentification:(NSNumber *)roverID
                                                                                         sol:(NSNumber *) sol
                                                                                      camera:(NSString *) cameraName
                                                                                   earthDate:(NSString *) earthDate
                                                                                    imageURL:(NSURL *) imageURL];
    return photo;
}

@end
