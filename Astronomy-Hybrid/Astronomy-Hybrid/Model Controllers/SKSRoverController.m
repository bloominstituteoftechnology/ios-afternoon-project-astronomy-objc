//
//  SKSRoverController.m
//  Astronomy-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "SKSRoverController.h"

@implementation SKSRoverController

static NSString * const baseURLString = @"https://api.nasa.gov/mars-photos/api/v1/";

- (void)photoManifestForRover:(void (^)(NSError *error))completion {

    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    [baseURL URLByAppendingPathComponent:@"manifests/curiosity?api_key=DEMO_KEY"];

    [[[NSURLSession sharedSession] dataTaskWithURL:baseURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error) {
            completion(error);
        }

        NSError *jsonError = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

        if (jsonError) {
            completion(jsonError);
        }



        if (![dictionary isKindOfClass:[NSDictionary class]]) {
            NSError *dictionaryError = (NSError *)dictionary;
            NSLog(@"It is not of dictionary type %@", [dictionaryError localizedDescription]);
            completion(dictionaryError);
        }

        NSDictionary *photoManifest = dictionary[@"photo_manifest"];
        NSString *name = photoManifest[@"name"];
        NSLog(@"Name: %@", name);

        NSArray *photoDictionaries = photoManifest[@"photos"];
        NSLog(@"Number of photos: %lu", photoDictionaries.count);
        completion(nil);


    }] resume];
}

- (void)photosForRoverOnSol:(NSString *)sol completion:(void (^)(NSError *error))completion {

    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:TRUE];

    NSURLQueryItem *solItem = [NSURLQueryItem queryItemWithName:@"sol" value:sol];
    NSURLQueryItem *apiKey = [NSURLQueryItem queryItemWithName:@"api_key" value:@"DEMO_KEY"];
    [components setQueryItems:@[solItem, apiKey]];

    [[[NSURLSession sharedSession] dataTaskWithURL:baseURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error) {
            completion(error);
        }

        NSError *jsonError = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

        if (jsonError) {
            completion(jsonError);
        }



        if (![dictionary isKindOfClass:[NSDictionary class]]) {
            NSError *dictionaryError = (NSError *)dictionary;
            NSLog(@"It is not of dictionary type %@", [dictionaryError localizedDescription]);
            completion(dictionaryError);
        }

        NSArray *photos = dictionary[@"photos"];
        NSLog(@"Sol 10 Number of photos: %lu", photos.count);
        completion(nil);


    }] resume];
}

@end
