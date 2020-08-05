//
//  LSIMarsRoverController.m
//  AstronomyOBJc
//
//  Created by Kelson Hartle on 7/25/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import "LSIMarsRoverController.h"
#import "AstronomyOBJc-Swift.h"
#import "LSISolDetails.h"
#import "LSIMarsCamera.h"
#import "LSIMarsRoverPhotoReference.h"
 

/* GOAL ⚠️
 https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity?api_key=qzGsj0zsKk6CA9JZP1UjAbpQHabBfaPg2M5dGMB7
 - _url : https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity?api_key=qzGsj0zsKk6CA9JZP1UjAbpQHabBfaPg2M5dGMB7
 */


//apikey 6uIKekXwxAAc5xXCn1jv0667fXDZJGlP813TJOhp
//https://api.nasa.gov/planetary/apod?api_key=6uIKekXwxAAc5xXCn1jv0667fXDZJGlP813TJOhp

// Manifest //https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity/api_key=6uIKekXwxAAc5xXCn1jv0667fXDZJGlP813TJOhp


/*
 EXTRA https://api.nasa.gov/mars-photos/api/v1/rovers/Curiosity/photos?sol=3&api_key=qzGsj0zsKk6CA9JZP1UjAbpQHabBfaPg2M5dGMB7
 
 BASEURL - https://api.nasa.gov/mars-photos/api/v1
 
-- EXAMPLE QUERY --
This will give us the pictures from the curiosity from sol 1000 from the fhaz camera.
 https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&camera=fhaz&api_key=DEMO_KEY
 
 This will give us all photos from one single day back
 https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=12&api_key=DEMO_KEY
 
 
 This will give you one image back from the server.
 using the image url given from the json given from the url above.
 */

@implementation LSIMarsRoverController

- (void)fetchMarsRoverWithRoverName:(NSString *)roverName completionBlock:(LSIMarsRoverFetcherCompletion)completion {
    
    NSURL *url = [[self class] urlForInfoForRover:roverName];
    
    NSURLSessionDataTask *dataTask = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"URL: ❇️ %@",url);
        
        if (error) {
            completion(nil,error);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            completion(nil,jsonError);
            return;
        }
        
        NSLog(@"JSON:🆕 %@", json);
        
        MarsRover *roverReturnedFromApi  = [[MarsRover alloc] initWithDictionary:json];
        
        if (roverReturnedFromApi) {
            completion(roverReturnedFromApi, nil);
            return;
        }
        
    }];
    
    [dataTask resume];
    
    
    
}


- (void)fetchMarsRoverPhotosFromRover:(MarsRover *)photoRef onSol:(NSNumber *)sol completionBlock:(LSIMarsRoverPhotosFetcherCompletion)completion {
    
    NSURL *url = [[self class] urlForPhotosFromRover:photoRef.name onSol: sol];
    
        NSURLSessionDataTask *dataTask = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"URL: ❇️ %@",url);
    
            if (error) {
                completion(nil,error);
                return;
            }
    
            NSError *jsonError = nil;
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            if (!jsonDict || ![jsonDict isKindOfClass:[NSDictionary class]]) {
                NSDictionary *userInfo = nil;
                if (error) { userInfo = @{NSUnderlyingErrorKey : error}; }
                NSError *localError = [NSError errorWithDomain:@"com.LambdaSchool.Astronomy.ErrorDomain" code:-1 userInfo:userInfo];
                return completion(nil, localError);
            }
            
//            NSDictionary *manifestDictionary = jsonDict[@"photo_manifest"];

            NSArray *photoDictionaries = jsonDict[@"photos"];
            NSMutableArray *photos = [NSMutableArray array];
            for (NSDictionary *dict in photoDictionaries) {
                LSIMarsRoverPhotoReference *photo = [[LSIMarsRoverPhotoReference alloc] initWithDictionary:dict];
                if (!photo) { continue; }
                [photos addObject:photo];
            }
            
            completion(photos, nil);
        }];
    
        [dataTask resume];
}

/*
 OBJC
 // Fast prototype to make sure it's working (UI Image downloading from server)
 
 // MUST Change url to be secure using file given in url+secure.
 NSURL *photoURL = //Use NSURLComponents to create photo URL from API data (sol # + 1st photo in list)'
 
 NSError *imageError = nil;
 NSData *imageData = [NSData dataWithContentsOfURL:photoURL options: 0 error: &error];
 
 if (imageError) {
    NSLog(@"ImageError", imageError);
    return;
 }
UIImage *image = [UIImage imageWithData: imageData];
 
 TODO: Update the UI on the main thread but can test using synchronous for now.
 imageView.image = image;
 
 */

+ (NSURL *)baseURL {
    return [NSURL URLWithString: @"https://api.nasa.gov/mars-photos/api/v1"] ;
}

+ (NSString *)apiKey
{
    return @"6uIKekXwxAAc5xXCn1jv0667fXDZJGlP813TJOhp";
}

+ (NSURL *)roversEndpoint
{
    NSURL *url = [[self baseURL] URLByAppendingPathComponent:@"rovers"];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:@"api_key" value:[self apiKey]]];
    return urlComponents.URL;
}

+ (NSURL *)urlForInfoForRover:(NSString *)roverName
{
    NSURL *url = [self baseURL];
    url = [url URLByAppendingPathComponent:@"manifests"];
    url = [url URLByAppendingPathComponent:roverName];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:@"api_key" value:[self apiKey]]];
    return urlComponents.URL;
}

+ (NSURL *)urlForPhotosFromRover:(NSString *)roverName onSol:(NSNumber*)sol
{
    NSURL *url = [self baseURL];
    url = [url URLByAppendingPathComponent:@"rovers"];
    url = [url URLByAppendingPathComponent:roverName];
    url = [url URLByAppendingPathComponent:@"photos"];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    NSString *testString = [NSString stringWithFormat:@"%@",sol];
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"sol" value:testString],
        [NSURLQueryItem queryItemWithName:@"api_key" value:[self apiKey]]
    ];
    
    return urlComponents.URL;
}



@end
