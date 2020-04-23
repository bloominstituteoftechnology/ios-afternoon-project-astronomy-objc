//
//  RoverPhoto.m
//  Astronomy-ObSwiftive-c
//
//  Created by Craig Swanson on 4/20/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import "RoverPhoto.h"
#import "NSURL+SecureHTTP.h"

@implementation RoverPhoto

-(instancetype)initWithPhotoID:(uint)photoID
                           sol:(int)sol
                      photoURL:(NSURL *)photoURL
                    cameraName:(NSString *)cameraName
                     earthDate:(NSDate *)earthDate {
    if (self = [self init]) {
        _photoID = photoID;
        _sol = sol;
        _photoURL = photoURL;
        _cameraName = cameraName;
        _earthDate = earthDate;
    }
    return self;
}

-(instancetype)initWithRoverPhotos:(NSArray<RoverPhoto *> *)roverPhotos {
    if (self = [self init]) {
        _roverPhotos = roverPhotos;
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSArray *roverPhotos = dictionary[@"photos"];
    NSMutableArray *roverPhotosArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in roverPhotos) {
        NSNumber *photoID = dictionary[@"id"];
        NSNumber *sol = dictionary[@"sol"];
        NSString *photoURLString = dictionary[@"img_src"];
        NSDictionary *cameraDictionary = dictionary[@"camera"];
        NSString *cameraName = cameraDictionary[@"full_name"];
        NSString *jsonDateString = dictionary[@"earth_date"];
        NSDate *earthDate = [dateFormatter dateFromString:jsonDateString];
        
        NSURL *photoURL = [NSURL URLWithString:photoURLString];
        NSURL *secureURL = [NSURL convertHTTPtoHTTPS:photoURL];
        
        if ([photoID isKindOfClass:[NSNull class]]) {
            photoID = nil;
        }
        if ([sol isKindOfClass:[NSNull class]]) {
            sol = nil;
        }
        if ([photoURL isKindOfClass:[NSNull class]]) {
            photoURL = nil;
        }
        if ([cameraName isKindOfClass:[NSNull class]]) {
            cameraName = nil;
        }
        
        RoverPhoto *newRoverPhoto = [[RoverPhoto alloc] initWithPhotoID:photoID.unsignedIntValue sol:sol.intValue photoURL:secureURL cameraName:cameraName earthDate:earthDate];
        
        [roverPhotosArray addObject:newRoverPhoto];
    }
    self = [self initWithRoverPhotos:roverPhotosArray];
    return self;
}

@end

/*
 {
 "photos": [
 {
 "id": 518386,
 "sol": 1147,
 "camera": {
 "id": 20,
 "name": "FHAZ",
 "rover_id": 5,
 "full_name": "Front Hazard Avoidance Camera"
 },
 "img_src": "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01147/opgs/edr/fcam/FLB_499317313EDR_F0500848FHAZ00323M_.JPG",
 "earth_date": "2015-10-28",
 "rover": {
 "id": 5,
 "name": "Curiosity",
 "landing_date": "2012-08-06",
 "launch_date": "2011-11-26",
 "status": "active",
 "max_sol": 2736,
 "max_date": "2020-04-17",
 "total_photos": 416179,
 "cameras": [
 {
 "name": "FHAZ",
 "full_name": "Front Hazard Avoidance Camera"
 },
 {
 "name": "NAVCAM",
 "full_name": "Navigation Camera"
 },
 {
 "name": "MAST",
 "full_name": "Mast Camera"
 },
 {
 "name": "CHEMCAM",
 "full_name": "Chemistry and Camera Complex"
 },
 {
 "name": "MAHLI",
 "full_name": "Mars Hand Lens Imager"
 },
 {
 "name": "MARDI",
 "full_name": "Mars Descent Imager"
 },
 {
 "name": "RHAZ",
 "full_name": "Rear Hazard Avoidance Camera"
 }
 ]
 }
 },
 */
