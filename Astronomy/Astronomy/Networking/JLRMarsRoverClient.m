//
//  JLRMarsRoverClient.m
//  Astronomy
//
//  Created by Jesse Ruiz on 12/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

#import "JLRMarsRoverClient.h"
#import "Astronomy-Swift.h"

@implementation JLRMarsRoverClient

// MARK: - Properties
static NSString *const baseURLString = @"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos";
static NSString *const apiKey = @"CFz2eHHSlBamJIZOeZG0FOAzXEypfmmpHdFmMoFe";

- (void)fetchPhotos:(double)sol
         completion:(void (^)(NSArray<MarsPhotoReference *> *photo, NSError *error))completion{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    
    NSNumber *solNum = [NSNumber numberWithDouble:sol];
    NSURLQueryItem *solSearch = [NSURLQueryItem queryItemWithName:@"sol" value:[solNum stringValue]];
    
    NSURLQueryItem *apiKeyItem = [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey];
    [components setQueryItems:@[solSearch, apiKeyItem]];
    
    NSURL *url = [components URL];
    NSLog(@"URL: %@", url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Search Results");
        
        if (error) {
            return completion(nil, error);
        }
        
        if (data == nil) {
            return completion(nil, [[NSError alloc] init]);
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            return completion(nil, error);
        }
        
        if(![json isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON was not a top level dictionary as expected");
            completion(nil, [[NSError alloc] init]);
        }
        
        NSArray *photosArray = json[@"photos"];
        NSMutableArray *roverPhotos = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dictionary in photosArray) {
            MarsPhotoReference *photo = [[MarsPhotoReference alloc] initWithDictionary:dictionary];
            [roverPhotos addObject:photo];
        }
        self.photos = roverPhotos;
        completion(roverPhotos, nil);
    }];
    [task resume];
}

@end
