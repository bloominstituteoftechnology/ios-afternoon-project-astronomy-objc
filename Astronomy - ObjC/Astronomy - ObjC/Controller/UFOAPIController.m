//
//  UFOAPIController.m
//  Astronomy - ObjC
//
//  Created by Ufuk Türközü on 20.04.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

#import "UFOAPIController.h"
#import "UFOMarsPhoto.h"

@implementation UFOAPIController

- (void)fetchPhotoWithRoverName:(NSString *)roverName
                            sol:(int)sol
                     completion: (void(^)(NSArray<UFOMarsPhoto *> *photos))completion {
    static NSString *baseURLString = @"https://api.nasa.gov/mars-photos/api/v1";
    static NSString *apiKey = @"hjWKVcrc8T02tVqAgdqg57xCpNKEitiQlWDEbtXb";
    NSURL *url = [NSURL URLWithString:baseURLString];
    url = [url URLByAppendingPathComponent:@"rovers"];
    url = [url URLByAppendingPathComponent:roverName];
    url = [url URLByAppendingPathComponent:@"photos"];
    
    NSString *solString = [NSString stringWithFormat:@"%i", sol];
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:true];
    NSArray *queryItems = @[[NSURLQueryItem queryItemWithName:@"sol" value:solString],
                            [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey]];
    components.queryItems = queryItems;
    
    NSURL *requestUrl = components.URL;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error fetching photo: %@", error);
            completion(nil);
            return;
        }
        
        if (!data) {
            NSLog(@"No data: %@", data);
            completion(nil);
            return;
        }
        
        error = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error) {
            NSLog(@"Error decoding JSON from data: %@", error);
            completion(nil);
            return;
        }
        
        if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"expected dictionary: %@", error);
            completion(nil);
            return;
        }
        
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (!jsonDict || ![jsonDict isKindOfClass:[NSDictionary class]]) {
            if (error) {
                NSLog(@"Error decoding jsonDict: %@", error);
            }
            return completion(nil);
        }
        
        NSArray *photoDictionaries = jsonDict[@"photos"];
        NSMutableArray *photos = [NSMutableArray array];
        for (NSDictionary *dict in photoDictionaries) {
            UFOMarsPhoto *photo = [[UFOMarsPhoto alloc] initWithDictionary:dict];
            if (photo) {
                [photos addObject:photo];
                NSLog(@"PHOTOS: %@", photos);
            }
        }
        completion(photos);
    }] resume];
}

//- (void)fetchSinglePhoto:(void(^)(UFOMarsPhoto *, NSError *error))completion {
//    
//    NSURL *requestUrl = @"http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/00012/opgs/edr/ccam/CR0_398560983EDR_F0030004CCAM03012M_.JPG";
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
//    
//    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        
//        if (error) {
//            NSLog(@"Error fetching photo: %@", error);
//            completion(nil, error);
//            return;
//        }
//        
//        if (!data) {
//            NSLog(@"No data: %@", data);
//            completion(nil, error);
//            return;
//        }
//        
//        error = nil;
//        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//        if (error) {
//            NSLog(@"Error decoding JSON from data: %@", error);
//            completion(nil, error);
//            return;
//        }
//        
//        if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
//            NSLog(@"expected dictionary: %@", error);
//            completion(nil, error);
//            return;
//        }
//        
//        UFOMarsPhoto *photo = [[UFOMarsPhoto alloc] initWithDictionary:dictionary];
//        completion(photo, nil);
//        
//    }] resume];
//}

@end
