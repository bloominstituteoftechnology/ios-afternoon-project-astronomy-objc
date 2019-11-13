//
//  JLCPhotoController.m
//  iOS9-Astronomy
//
//  Created by Jake Connerly on 11/12/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

#import "JLCPhotoController.h"
#import "JLCMarsPhoto.h"
#import "JLCMarsRover.h"

@implementation JLCPhotoController

static NSString *const baseURLString = @"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos";
static NSString *const apiKey = @"vQblSa0mIwQQsaR8gD7E0a6oj84C13qSLOpDyaSO";

- (void)fetchPhotosfromSol:(double)sol
                completion:(void (^)(JLCMarsPhoto *photo, NSError *error))completion {
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    
    NSNumber *solNumber = [NSNumber numberWithDouble:sol];
    NSURLQueryItem *solToSearch = [NSURLQueryItem queryItemWithName:@"sol" value:[solNumber stringValue]];
    
    NSURLQueryItem *apiKeyQueryItem = [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey];
    [components setQueryItems:@[solToSearch, apiKeyQueryItem]];
    
    NSURL *url = [components URL];
    NSLog(@"url: %@", url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"Search Results");
        
    // Check for error, call completion
        if (error) {
            completion(nil, error);
            return;
        }
        
        if (data == nil) {
            completion(nil, [[NSError alloc] init]);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if(jsonError) {
            completion(nil, error);
            return;
        }
        
        // Check for data, parse it
        if(![json isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON was not a top level dictionary as expected");
            completion(nil, [[NSError alloc] init]);
        }
        
        
        NSArray *photosArray = json[@"photos"];
        NSMutableArray *roverPhotos = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dictionary in photosArray) {
            JLCMarsPhoto *photo = [[JLCMarsPhoto alloc] initWithDictionary:dictionary];
            [roverPhotos addObject:photo];
        }
        self.photos = roverPhotos;
        completion(roverPhotos, nil);
    }];
    [task resume];
    
}




@end
