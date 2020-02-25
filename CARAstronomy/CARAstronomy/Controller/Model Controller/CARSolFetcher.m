//
//  CARSolFetcher.m
//  CARAstronomy
//
//  Created by Chad Rutherford on 2/24/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import "CARSolFetcher.h"
#import "CARMarsSol.h"
#import "LSIErrors.h"
#import "LSILog.h"

@implementation CARSolFetcher

static NSString *const baseURLString = @"https://api.nasa.gov/mars-photos/api/v1/rovers";
static NSString *const apiKey = @"E1mvXHcz2wixp2XkoacEfdqeZUomUQZXNdm4j13Z";

- (void)fetchPhotosForRover:(NSString *)rover
                    withSol:(NSNumber *)sol
               completion:(CARSolFetcherCompletion)completion {
    NSURL *baseURL = [[[NSURL URLWithString:baseURLString] URLByAppendingPathComponent:rover] URLByAppendingPathComponent:@"photos"];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"sol" value: [NSString stringWithFormat:@"%d", sol.intValue]],
        [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey]
    ];
    NSURL *url = urlComponents.URL;
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        if (!data) {
            NSError *dataError = errorWithMessage(@"Data should not be nil from API request.", LSIDataNilError);
            completion(nil, dataError);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            completion(nil, jsonError);
            return;
        }
        
        NSArray *photosArray = json[@"photos"];
        NSMutableArray *photos = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in photosArray) {
            CARMarsSol *sol = [[CARMarsSol alloc] initWithDictionary:dictionary];
            [photos addObject:sol];
        }
        if (!photos) {
            NSError *parsingError = errorWithMessage(@"Unable to parse JSON objects", LSIJSONDecodeError);
            completion(nil, parsingError);
            return;
        }
        
        completion(photos, nil);
    }] resume];
}
@end


/*
 {
 "photos": [
   {
     "id": 102693,
     "sol": 1000,
     "camera": {
       "id": 20,
       "name": "FHAZ",
       "rover_id": 5,
       "full_name": "Front Hazard Avoidance Camera"
     },
     "img_src": "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01000/opgs/edr/fcam/FLB_486265257EDR_F0481570FHAZ00323M_.JPG",
     "earth_date": "2015-05-30",
     "rover": {
       "id": 5,
       "name": "Curiosity",
       "landing_date": "2012-08-06",
       "launch_date": "2011-11-26",
       "status": "active",
       "max_sol": 2540,
       "max_date": "2019-09-28",
       "total_photos": 366206,
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
