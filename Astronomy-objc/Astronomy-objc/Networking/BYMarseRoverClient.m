//
//  BYMarseRoverClient.m
//  Astronomy-objc
//
//  Created by Bradley Yin on 10/14/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

#import "BYMarseRoverClient.h"
#import "BYMarsRover.h"

@implementation BYMarseRoverClient

static NSString *baseURLString = @"https://api.nasa.gov/mars-photos/api/v1";
static NSString *apiKey = @"bSNJ3GS68u6y5tr1lPJZB4pIGHFzt7thLao353IK";

- (void)fetchMarsRoverWithName:(NSString *)name completionBlock:(BYRoverCompletionBlock)completionBlock {
    // Create API request
    
    // Setup the URL
    
    NSString *manifestString = [baseURLString stringByAppendingPathComponent:@"manifests"];
    NSString *curiosityString = [manifestString stringByAppendingPathComponent:name];
    
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:curiosityString];
    
    
    
    // Query Parameters
    
    NSArray *queryItems = @[
                            [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey]
                            ];
    
    urlComponents.queryItems = queryItems;
    
    NSURL *url = urlComponents.URL;
    NSLog(@"URL: %@", url);
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // Handle the responses (error vs. data)

        // Call the completion block as needed
        // check the errors
        
        if (error) {
            NSLog(@"Error fetching marsRover: %@", error);
            completionBlock(nil, error);
            return;
        }
        
        // parse the data
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            NSLog(@"JSON Error: %@", jsonError);
            completionBlock(nil, jsonError);
            return;
        }
        
        // TODO: Parse the data
        NSLog(@"JSON: %@", json);
        //Convert from dictionary to a [Quake] using NSArray
        NSDictionary *photoManifest = json[@"photo_manifest"];
        
        BYMarsRover *rover = [[BYMarsRover alloc] initWithDictionary:photoManifest];
        
        completionBlock(rover, nil);
    }];
    [task resume];
    
}

- (void)fetchPhotosFromRover:(BYMarsRover *)rover onSol:(NSNumber *)sol completionBlock:(BYPhotoReferenceCompletionBlock)completionBlock {

    NSString *roversString = [baseURLString stringByAppendingPathComponent:@"rovers"];
    NSString *roverNameString = [roversString stringByAppendingPathComponent:rover.name];
    NSString *photosString = [roverNameString stringByAppendingPathComponent:@"photos"];
      
      
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:photosString];
      
      
      
      // Query Parameters
      
      NSArray *queryItems = @[
                            [NSURLQueryItem queryItemWithName:@"sol" value:[sol stringValue]],
                            [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey]
                              ];
      
      urlComponents.queryItems = queryItems;
      
      NSURL *url = urlComponents.URL;
      NSLog(@"URL: %@", url);
      
      NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
          
          // Handle the responses (error vs. data)

          // Call the completion block as needed
          // check the errors
          
          if (error) {
              NSLog(@"Error fetching marsRoverPhotos: %@", error);
              completionBlock(nil, error);
              return;
          }
          
          // parse the data
          NSError *jsonError = nil;
          NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
          if (jsonError) {
              NSLog(@"JSON Error: %@", jsonError);
              completionBlock(nil, jsonError);
              return;
          }
          
          // TODO: Parse the data
          NSLog(@"JSON: %@", json);
          //Convert from dictionary to a [Quake] using NSArray
          NSDictionary *photoManifest = json[@"photo_manifest"];
          
          BYMarsRover *rover = [[BYMarsRover alloc] initWithDictionary:photoManifest];
          
          completionBlock(rover, nil);
      }];
      [task resume];
}

@end
