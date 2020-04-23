//
//  CDGRoverClient.m
//  AstronomyObjC
//
//  Created by Chris Gonzales on 4/21/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

#import "CDGRoverClient.h"
#import "CDGRover.h"
#import "CDGPhoto.h"

@implementation CDGRoverClient

+ (NSURL *)baseURL
{
    return [NSURL URLWithString:@"https://api.nasa.gov/mars-photos/api/v1"];
}

+ (NSString *)apiKey
{
    return @"Lrc1ZG6wCpGvVF4u30o81pcKOb7l9bkcSSFtpZKs";
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

+ (NSURL *)urlForPhotosFromRover:(NSString *)roverName onSol:(NSInteger)sol
{
    NSURL *url = [self baseURL];
    url = [url URLByAppendingPathComponent:@"rovers"];
    url = [url URLByAppendingPathComponent:roverName];
    url = [url URLByAppendingPathComponent:@"photos"];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:@"sol" value:[@(sol) stringValue]],
                                 [NSURLQueryItem queryItemWithName:@"api_key" value:[self apiKey]]];
    return urlComponents.URL;
}

- (void)fetchAllMarsRoversWithCompletion:(void(^)(NSArray<NSString *> *roverNames, NSError *error))completion{
    
  NSURL *url = [[self class] roversEndpoint];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            return completion(nil, error);
        }
        
        if (!data) {
            return completion(nil, [NSError errorWithDomain:@"com.ChristopherGonzales.AstronomyObjc.ErrorDomain" code:-1 userInfo:nil]);
        }
        
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSArray *roverDicts = nil;
        if (!jsonDict || ![jsonDict isKindOfClass:[NSDictionary class]] ||
            !(roverDicts = jsonDict[@"rovers"])) {
            return completion(nil, [NSError errorWithDomain:@"com.ChristopherGonzales.AstronomyObjc.ErrorDomain" code:-1 userInfo:nil]);
        }
        
        NSMutableArray *roverNames = [NSMutableArray array];
        for (NSDictionary *dict in roverDicts) {
            NSString *name = dict[@"name"];
            if (name) { [roverNames addObject:name]; }
        }
        completion(roverNames, nil);
    }] resume];
}

- (void)fetchMissionManifestForRover:(NSString *)name completion:(void(^)(CDGRover *rover, NSError *error))completion {

    NSURL *url = [[self class] urlForInfoForRover:name];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            return completion(nil, error);
        }
        
        if (!data) {
            return completion(nil, [NSError errorWithDomain:@"com.ChristopherGonzales.AstronomyObjc.ErrorDomain" code:-1 userInfo:nil]);
        }
        
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSDictionary *manifest = nil;
        if (!jsonDict || ![jsonDict isKindOfClass:[NSDictionary class]] ||
            !(manifest = jsonDict[@"photo_manifest"])) {
            return completion(nil, [NSError errorWithDomain:@"com.ChristopherGonzales.AstronomyObjc.ErrorDomain" code:-1 userInfo:nil]);
        }
        
        completion([[CDGRover alloc] initWithDictionary:manifest], nil);
    }] resume];
}

- (void)fetchPhotosFromRover:(CDGRover *)rover onSol:(NSInteger)sol completion:(void(^)(NSArray<CDGPhoto *> *photos, NSError *error))completion {
    if (!rover) {
        NSLog(@"%s called with a nil rover.", __PRETTY_FUNCTION__);
        return completion(nil, [NSError errorWithDomain:@"com.ChristopherGonzales.AstronomyObjc.ErrorDomain" code:-2 userInfo:nil]);
    }
    
    NSURL *url = [[self class] urlForPhotosFromRover:rover.name onSol:sol];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            return completion(nil, error);
        }
        
        if (!data) {
            return completion(nil, [NSError errorWithDomain:@"com.ChristopherGonzales.AstronomyObjc.ErrorDomain" code:-1 userInfo:nil]);
        }
        
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (!jsonDict || ![jsonDict isKindOfClass:[NSDictionary class]]) {
             return completion(nil, [NSError errorWithDomain:@"com.ChristopherGonzales.AstronomyObjc.ErrorDomain" code:-1 userInfo:nil]);
        }

        NSArray *photoDictionaries = jsonDict[@"photos"];
        NSMutableArray *photos = [NSMutableArray array];
        for (NSDictionary *dict in photoDictionaries) {
            CDGPhoto *photo = [[CDGPhoto alloc] initWithDictionary:dict];
            if (!photo) { continue; }
            [photos addObject:photo];
        }
        completion(photos, nil);
    }] resume];
}

- (void)fetchImageDataForPhoto:(CDGPhoto *)photo completion:(void(^)(NSData *imageData, NSError *error))completion {
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:photo.imageURL resolvingAgainstBaseURL:YES];
    urlComponents.scheme = @"https";
    NSURL *imageURL = urlComponents.URL;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            return completion(nil, error);
        }
        
        if (!data) {
            return completion(nil, [NSError errorWithDomain:@"com.ChristopherGonzales.AstronomyObjc.ErrorDomain" code:-1 userInfo:nil]);
        }
        
        completion(data, nil);
    }] resume];
}
@end
