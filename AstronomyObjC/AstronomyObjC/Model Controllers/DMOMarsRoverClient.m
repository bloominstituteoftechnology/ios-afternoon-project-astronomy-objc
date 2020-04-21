//
//  MarsRoverClient.m
//  AstronomyObjC
//
//  Created by morse on 1/26/20.
//  Copyright © 2020 morse. All rights reserved.
//

#import "DMOMarsRoverClient.h"
#import "DMORover.h"
#import "DMOSolDescription.h"
#import "DMOPhotoReference.h"

@interface DMOMarsRoverClient () {}

@property (nonatomic)NSURL *baseURL;
@property (nonatomic)NSString *apiKey;

- (void) fetchFromURL:(NSURL *)url completion:(void (^)(NSDictionary *dictionary, NSError *error))completion;
- (NSURL *) urlForRoverInfo:(NSString *)rover;
- (NSURL *) urlForPhotoInfo:(NSString *)rover onSol:(int)sol;
- (NSURLQueryItem *) quearyItemForAPIKey;

@end

@implementation DMOMarsRoverClient

- (instancetype)init {
    self = [super init];
    if (self) {
        _baseURL = [NSURL URLWithString:@"https://api.nasa.gov/mars-photos/api/v1"];
        _apiKey = @"qzGsj0zsKk6CA9JZP1UjAbpQHabBfaPg2M5dGMB7";
    }
    return self;
}

- (void) fetchMarsRoverWithName:(NSString *)name completion:(void (^)(DMORover *rover, NSError *error))completion {
    NSURL *url = [self urlForRoverInfo:name];
    NSLog(@"%@", url);
    
    [self fetchFromURL:url completion:^(NSDictionary *dictionary, NSError *error) {
        NSDictionary *roverDictionary = dictionary[@"photo_manifest"];
//        NSLog(@"%@", roverDictionary);
        DMORover *rover = [[DMORover alloc] initWithDictionary:roverDictionary];
        
        completion(rover, nil);
    }];
}

- (void) fetchPhotosFromRover:(DMORover *)rover onSol:(int)sol completion:(void (^)(NSArray<DMOPhotoReference *> *photoRefs, NSError *error))completion {
    NSMutableArray<DMOPhotoReference *> *photoRefs = [[NSMutableArray alloc] init];
    NSURL *url = [self urlForPhotoInfo:rover.name onSol:sol];
    NSLog(@"Photo URL: %@", url);
    
    [self fetchFromURL:url completion:^(NSDictionary *dictionary, NSError *error) {
        
        NSArray *photoDictionaries = dictionary[@"photos"];
        for (NSDictionary *photoDictionary in photoDictionaries) {
            NSURL *imageURL = [NSURL URLWithString:photoDictionary[@"img_src"]];
//            NSLog(@"%@", imageURL);
            NSURLComponents *components = [NSURLComponents componentsWithURL:imageURL resolvingAgainstBaseURL:YES];
            [components setQueryItems:@[[self quearyItemForAPIKey]]];
            DMOPhotoReference *photoReference = [[DMOPhotoReference alloc] initWithID:[photoDictionary[@"id"] intValue] imageURL:[components URL]];
//            NSLog(@"%i, %@", photoReference.id, photoReference.imageURL);
            [photoRefs addObject:photoReference];
        }
        completion(photoRefs, error);
    }];
}

- (void) fetchFromURL:(NSURL *)url completion:(void (^)(NSDictionary *dictionary, NSError *error))completion {
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            completion(nil, jsonError);
            return;
        }
        
        if (![dictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON was not an NSDictionary");
            completion(nil, [[NSError alloc] init]);
            return;
        }
        
        completion(dictionary, nil);
    }] resume];
}

- (NSURL *) urlForRoverInfo:(NSString *)rover {
    NSURL *url = self.baseURL;
    url = [url URLByAppendingPathComponent:@"manifests"];
    url = [url URLByAppendingPathComponent:rover];
//    NSURLQueryItem *apiItem = [self quearyItemForAPIKey];
    NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    [components setQueryItems:@[[self quearyItemForAPIKey]]];
    return [components URL];
}

- (NSURL *) urlForPhotoInfo:(NSString *)rover onSol:(int)sol {
    NSURL *url = self.baseURL;
    url = [url URLByAppendingPathComponent:@"rovers"];
    url = [url URLByAppendingPathComponent:rover];
    url = [url URLByAppendingPathComponent:@"photos"];
    NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    NSString *solString = [NSString stringWithFormat:@"%i", sol ];
    NSURLQueryItem *solItem = [NSURLQueryItem queryItemWithName:@"sol" value:solString];
    [components setQueryItems:@[solItem, [self quearyItemForAPIKey]]];
    return [components URL];
}

- (NSURLQueryItem *) quearyItemForAPIKey {
    return [NSURLQueryItem queryItemWithName:@"api_key" value:self.apiKey];
}

@end
