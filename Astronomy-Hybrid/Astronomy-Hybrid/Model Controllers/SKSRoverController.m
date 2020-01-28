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

@property (nonatomic, nonnull) NSMutableArray<SKSPhotoReference *> *photoReferences;

@end

@implementation SKSRoverController

static NSString * const baseURLString = @"https://api.nasa.gov/mars-photos/api/v1/";

- (instancetype)init
{
    self = [super init];
    if (self) {
        _photoReferences = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)getPhotoReferences {
    return [self.photoReferences copy];
}

// MARK: - Network calls
- (void)photoManifestForRover:(nonnull void (^)(NSError * _Nullable))completion {

    NSString *urlString = [baseURLString stringByAppendingString:@"manifests/curiosity?api_key=DEMO_KEY"];
    NSURL *baseURL = [NSURL URLWithString:urlString];

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
        self.marsRover = [[SKSMarsRover alloc] initWithDictionary:photoManifest];

        completion(nil);

    }] resume];
}

- (void)photosForRoverOnSol:(nonnull NSString *)sol completion:(nonnull void (^)(NSError *_Nullable))completion {

    NSString *urlString = [baseURLString stringByAppendingString:@"rovers/curiosity/photos"];
    NSURL *baseURL = [NSURL URLWithString:urlString];
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:TRUE];

    //https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=DEMO_KEY
    NSURLQueryItem *solItem = [NSURLQueryItem queryItemWithName:@"sol" value:sol];
    NSURLQueryItem *apiKey = [NSURLQueryItem queryItemWithName:@"api_key" value:@"DEMO_KEY"];
    [components setQueryItems:@[solItem, apiKey]];

    NSURL *url = components.URL;

    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

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
        for (NSDictionary *photoDictionary in photos) {
            SKSPhotoReference *photo = [[SKSPhotoReference alloc] initWithDictionary:photoDictionary];
            [self.photoReferences addObject:photo];
        }

        NSLog(@"Sol 10 Number of photos: %lu", self.photoReferences.count);
        completion(nil);


    }] resume];
}

@end
