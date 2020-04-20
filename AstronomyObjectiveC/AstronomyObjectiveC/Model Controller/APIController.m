//
//  APIController.m
//  AstronomyObjectiveC
//
//  Created by Enrique Gongora on 4/20/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

#import "APIController.h"
#import "AstronomyObjectiveC-Swift.h"

static NSString *baseURL = @"https://api.nasa.gov/mars-photos/api/v1/rovers";

@interface APIController()

@property (nonatomic) NSMutableArray *internalSolPhotos;

@end

@implementation APIController

/// Default Init
- (instancetype)init {
    self = [super init];
    if (self) {
        // TODO: Remove later (for testing only)
        [self addTestPhotos];
        NSLog(@"init %lu", (unsigned long)self.internalSolPhotos.count);
    }
    return self;
}

/// Computed property for solPhotos array
- (NSArray *)solPhotos {
    return [self.internalSolPhotos copy];
}

/// Lazy init for internalSolPhotos
- (NSMutableArray *)internalSolPhotos {
    if (!_internalSolPhotos) {
        _internalSolPhotos = [[NSMutableArray alloc] init];
    }
    return _internalSolPhotos;
}

/// Mock Data (Doesn't work)
- (void)addTestPhotos {
    NSLog(@"called add test photos");
    [self.internalSolPhotos addObjectsFromArray:@[
        [[Rover alloc] initWithName:@"Bill" photos:@"test.jpg"],
        [[Rover alloc] initWithName:@"Bob" photos:@"test.jpg"],
        [[Rover alloc] initWithName:@"John" photos:@"test.jpg"]
    ]];
    
    NSLog(@"array after: %lu", self.internalSolPhotos.count);
}

- (void)fetchPhotos:(NSString *)strArtist completion:(void(^)(Rover *, NSError *error))completion {
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:baseURL];
    
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"s" value:strArtist]
    ];
    
    NSURL *url = urlComponents.URL;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSLog(@"request = %@", request);
    
    // Data Task
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data,
                                                                                   NSURLResponse * _Nullable response,
                                                                                   NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error fetching artist data: %@", error);
            completion(nil, error);
            return;
        }
        
        if (!data) {
            NSLog(@"Error returned from data task");
            completion(nil, error);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            NSLog(@"Error decoding JSON from data: %@", error);
            completion(nil, jsonError);
            return;
        }
        
        if(!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Error: Expected top level dictionary in JSON result: %@", error);
            completion(nil, error);
            return;
        }
        
        NSLog(@"Dictionary: %@", dictionary);
        
        if (dictionary[@"artists"] == nil) {
            NSLog(@"dictionary artists 107 controller: null");
            completion(nil, error);
            return;
        }

        Rover *roverData = [[Rover alloc] initWithName:@"curiosity" photos:@""];
        completion(roverData, nil);
    }] resume];
}

- (void)requestSinglePhotoWithCompletion:(void(^)(Rover *, NSError *error))completion {
    NSString *testURLString = @"http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/00012/opgs/edr/ccam/CR0_398560983EDR_F0030004CCAM03012M_.JPG";
    
    Rover *roverData = [[Rover alloc] initWithName:@"curiosity" photos:@""];
    completion(roverData, nil);
}

@end
