//
//  SKSRoverController.m
//  Astronomy-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "SKSRoverController.h"
#import "SKSMarsRover.h"
#import "SKSPhotoReference.h"

@interface SKSRoverController()

@end

@implementation SKSRoverController

static NSString * const baseURLString = @"https://api.nasa.gov/mars-photos/api/v1/";

// MARK: - Network calls
- (void)photoManifestForRover:(nonnull void (^)(SKSMarsRover *_Nullable, NSError * _Nullable))completion {

    NSString *urlString = [baseURLString stringByAppendingString:@"manifests/curiosity?api_key=DEMO_KEY"];
    NSURL *baseURL = [NSURL URLWithString:urlString];

    [[[NSURLSession sharedSession] dataTaskWithURL:baseURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error) {
            completion(nil, error);
        }

        NSError *jsonError = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

        if (jsonError) {
            completion(nil, jsonError);
        }



        if (![dictionary isKindOfClass:[NSDictionary class]]) {
            NSError *dictionaryError = (NSError *)dictionary;
            NSLog(@"It is not of dictionary type %@", [dictionaryError localizedDescription]);
            completion(nil, dictionaryError);
        }
        
        NSDictionary *photoManifest = dictionary[@"photo_manifest"];
        SKSMarsRover *rover = [[SKSMarsRover alloc] initWithDictionary:photoManifest];

        completion(rover, nil);

    }] resume];
}

- (void)photosForRoverOnSol:(NSInteger)sol completion:(nonnull void (^)(NSArray<SKSPhotoReference *> *_Nullable, NSError *_Nullable))completion {

    NSString *urlString = [baseURLString stringByAppendingString:@"rovers/curiosity/photos"];
    NSURL *baseURL = [NSURL URLWithString:urlString];
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:TRUE];

    //https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=DEMO_KEY
    NSString *solValue = [[NSNumber numberWithInteger:sol] stringValue];
    NSURLQueryItem *solItem = [NSURLQueryItem queryItemWithName:@"sol" value:solValue];
    NSURLQueryItem *apiKey = [NSURLQueryItem queryItemWithName:@"api_key" value:@"DEMO_KEY"];
    [components setQueryItems:@[solItem, apiKey]];

    NSURL *url = components.URL;

    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error) {
            completion(nil, error);
        }

        NSError *jsonError = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

        if (jsonError) {
            completion(nil, jsonError);
        }

        if (![dictionary isKindOfClass:[NSDictionary class]]) {
            NSError *dictionaryError = (NSError *)dictionary;
            NSLog(@"It is not of dictionary type %@", [dictionaryError localizedDescription]);
            completion(nil, dictionaryError);
        }

        NSArray *photos = dictionary[@"photos"];
        NSMutableArray<SKSPhotoReference *> *tempPhotoReferences = [[NSMutableArray alloc] init];
        for (NSDictionary *photoDictionary in photos) {
            SKSPhotoReference *photo = [[SKSPhotoReference alloc] initWithDictionary:photoDictionary];
            [tempPhotoReferences addObject:photo];
        }

        completion([tempPhotoReferences copy], nil);
    }] resume];
}

@end
