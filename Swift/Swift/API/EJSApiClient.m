//
//  EJSApiClient.m
//  Swift
//
//  Created by Enzo Jimenez-Soto on 7/21/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

#import "EJSApiClient.h"
#import "EJSNasaManifest.h"
#import "EJSSolPhoto.h"

static NSString *baseURLString = @"https://api.nasa.gov/mars-photos/api/v1";
static NSString *apiKey = @"rShurQFkW6eGo61RksJec09o5v9PvFRWfb3C00WG";

@implementation EJSApiClient

- (void)fetchManifestWithCompletionBlock:(EJSManifestFetcherCompletionBlock)completionBlock {
    NSURL *url = [[NSURL alloc] initWithString:baseURLString];
    NSURL *fullURL = [url URLByAppendingPathComponent:@"manifests/curiosity"];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:fullURL resolvingAgainstBaseURL:NO];
    
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"API_KEY" value:apiKey]
    ];
    
    NSURL *finalURL = urlComponents.URL;
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
        NSLog(@"URL: %@", finalURL);
        
        if (error) {
            completionBlock(nil, error);
            return;
        }
        
        if (!data) {
            NSError *dataError = [[NSError alloc] initWithDomain:@"com.sah.Astronomy" code:100 userInfo:nil];
            completionBlock(nil, dataError);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        if (jsonError) {
            completionBlock(nil, jsonError);
        }
        
        NSDictionary *manifestDictionary = jsonDictionary[@"photo_manifest"];
        
        EJSNasaManifest *mainfest = [[EJSNasaManifest alloc] initWithDictionary:manifestDictionary];
        
        completionBlock(mainfest, nil);
        
        
    }];
    
    [task resume];
    
}


- (void)fetchSolPhotosForRover:(NSString *)roverName solId:(NSNumber *)solId completionBlock:(EJSSolPhotoFetcherCompletionBlock)completionBlock {
    NSURL *url = [[NSURL alloc] initWithString:baseURLString];
    NSURL *fullURL = [url URLByAppendingPathComponent:@"rovers/curiosity/photos"];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:fullURL resolvingAgainstBaseURL:NO];
    
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"sol" value:solId.stringValue],
        [NSURLQueryItem queryItemWithName:@"API_KEY" value:apiKey]
    ];
    
    NSURL *finalURL = urlComponents.URL;
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"URL: %@", finalURL);
        
        if (error) {
            completionBlock(nil, error);
            return;
        }
        
        if (!data) {
            NSError *dataError = [[NSError alloc] initWithDomain:@"com.sah.Astronomy" code:100 userInfo:nil];
            completionBlock(nil, dataError);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *jsonPhotosDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        
        if (jsonError) {
            completionBlock(nil, jsonError);
        }
        
        NSArray<NSDictionary *> *jsonArray = jsonPhotosDictionary[@"photos"];
        
        NSMutableArray<EJSSolPhoto *> *solPhotos = [[NSMutableArray alloc] init];
        for (NSDictionary *solPhotoDictionary in jsonArray) {
            EJSSolPhoto *photo = [[EJSSolPhoto alloc] initWithDictionary:solPhotoDictionary];
            [solPhotos addObject:photo];
        }
        
        completionBlock(solPhotos, nil);
        
        
    }];
    
    [task resume];
}

- (void)fetchPhotoAtURL:(NSString *)urlString completionBlock:(EJSPhotoFetcherCompletionBlock)completionBlock {
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:NO];
    
    urlComponents.scheme = @"https";
    
    NSURL *finalURL = urlComponents.URL;
    
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"URL: %@", finalURL);
        
        if (error) {
            completionBlock(nil, error);
            return;
        }
        
        if (!data) {
            NSError *dataError = [[NSError alloc] initWithDomain:@"com.sah.Astronomy" code:100 userInfo:nil];
            completionBlock(nil, dataError);
            return;
        }
        
        completionBlock(data, nil);
        
    }];
    
    [task resume];
}

@end
