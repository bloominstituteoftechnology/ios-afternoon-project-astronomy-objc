//
//  RoverAPIController.m
//  Astronomy in OBJC
//
//  Created by Sal B Amer on 6/4/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

#import "RoverAPIController.h"
#import "../Resources/Astronomy_in_OBJC-Bridging-Header.h"
#import "MarsPhotos.h"
#import "NSObject+NSJSONSerialization.h"
#import "NSURL+UsingHTTPS.h"

//kmtGVW0TesibWG6PgP541goCdHq9UyqhEfhEdbo6
//https://api.nasa.gov/planetary/apod?api_key=kmtGVW0TesibWG6PgP541goCdHq9UyqhEfhEdbo6
//https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=kmtGVW0TesibWG6PgP541goCdHq9UyqhEfhEdbo6

static NSString *apiKey = @"kmtGVW0TesibWG6PgP541goCdHq9UyqhEfhEdbo6";

@implementation RoverAPIController

- (instancetype) initWithPhotos:(NSMutableArray *)photos
{
  self = [super init];
  if (self) {
    _photos = photos;
  }
  return self;
}

- (void) fetchMarsPhotosFromSol:(NSNumber *)sol
                completionBlock:(MarsPhotoCompletion)completionBlock
{
  //using curiosity rover
  NSURL *baseURLString = [NSURL URLWithString:@"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos"];
  NSURLComponents *components = [NSURLComponents componentsWithURL:baseURLString resolvingAgainstBaseURL:YES];
  NSURLQueryItem *solTerm [NSURLQueryItem queryItemWithName:@"sol" value:[NSString stringWithFormat:@"%i", sol.intValue]];
  NSURLQueryItem *pageNumber = [NSURLQueryItem queryItemWithName:@"page" value:[NSString stringWithFormat:@"%i", 1]];
  NSURLQueryItem *withAPIKey = [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey];
  NSURL *url = components.URL;
  
  //PRINT URL
  NSLog(@"%@", url);
  
  if (!url) {
    return;
  }
  
  NSURLSessionTask *task = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    if (error) {
      completionBlock(nil, error);
      return;
    }
    if (!data) {
      completionBlock(nil, [[NSError alloc] init]);
      return;
    }
    NSError *jsonError = nil;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    if (jsonError) {
      completionBlock(nil, error);
      return;
    }
    
    NSArray *photosArray = [[NSArray alloc] initArrayWithDictionary:dictionary];
    completionBlock(photosArray, nil);
  }];
  [task resume];
}

// fetch image
- (void)fetchImagesForPhotoRef:(MarsPhotos *)photoReferences completionBlock:(MarsSinglePhotoCompletion)completionBlock
{
  NSURL *url = photoReferences.imageURL.usingHTTPS;
  
  NSURLSessionTask * task = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    if (error) {
      completionBlock(nil, error);
      return;
    }
    if (!data) {
      completionBlock(nil, [[NSError alloc] init]);
      return;
    }
    //return data
    completionBlock(data, nil);
    return;
  }];
  [task resume];
}


@end
