//
//  KMLRoverController.m
//  Astronomy_ObjectiveC
//
//  Created by Kenny on 6/15/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

#import "KMLRoverController.h"
#import "KMLManifest.h"
#import "KMLSol.h"

@import UIKit;

@implementation KMLRoverController

static NSString *apiKey = @"Wxd9NWhBcpy0hG8AzQ7ycKyZl1ixjtwUsdFJR9Jg";
static NSString *baseURLString = @"https://api.nasa.gov/mars-photos/api/v1/";

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)fetchSolsFromRoverWithName:(NSString *)name completion:(void (^)(KMLManifest *))completion
{
    NSURL *baseURL = [NSURL URLWithString: baseURLString];
    
    NSString *roverString = [@"manifests/" stringByAppendingString:name];

    NSURL *fetchRoverURL = [NSURL URLWithString:roverString relativeToURL: baseURL];
    NSURLComponents *components = [NSURLComponents componentsWithURL:fetchRoverURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *apiQuery = [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey];
    components.queryItems = @[apiQuery];

    NSURLSessionTask *session = [NSURLSession.sharedSession dataTaskWithURL:components.URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching sols: %@", error);
            completion(nil);
            return;
        }

        if (!data) {
            NSLog(@"No data from sol task");
            completion(nil);
            return;
        }

        NSError *decodeError = nil;
        NSDictionary *decodeDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error: &decodeError];
        if (decodeError) {
            NSLog(@"Error decoding manifest: %@", decodeError);
            completion(nil);
            return;
        }

        KMLManifest *manifest = [[KMLManifest alloc] initWithDictionary:decodeDictionary];
        self.manifest = manifest;
        completion(manifest);

    }];
    [session resume];
}

- (void)fetchPhotosWithRoverName:(NSString *)name OnSol:(NSNumber *)sol completion:(void (^)(KMLSol *))completion
{
    NSURL *baseURL = [NSURL URLWithString: baseURLString];

    NSString *roverString = [[@"rovers/" stringByAppendingString:name] stringByAppendingString:@"/photos"];

    NSURL *fetchRoverURL = [NSURL URLWithString:roverString relativeToURL: baseURL];
    NSURLComponents *components = [NSURLComponents componentsWithURL:fetchRoverURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *solQuery = [NSURLQueryItem queryItemWithName:@"sol" value:sol.stringValue];
    NSURLQueryItem *apiQuery = [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey];
    components.queryItems = @[apiQuery, solQuery];

    NSURLSessionTask *session = [NSURLSession.sharedSession dataTaskWithURL:components.URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching photo from sol: %@ at url: %@: %@",sol.stringValue, components.URL, error);
            completion(nil);
            return;
        }

        if (!data) {
            NSLog(@"No data from photo task");
            completion(nil);
            return;
        }

        NSError *decodeError = nil;
        NSDictionary *decodeDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error: &decodeError];
        if (decodeError) {
            NSLog(@"Error decoding manifest: %@", decodeError);
            completion(nil);
            return;
        }

        NSArray *photoArray = decodeDictionary[@"photos"];

        NSMutableArray *photoOutputArray = [[NSMutableArray alloc] init];

        for (NSDictionary *photo in photoArray) {
            NSString *photoString = photo[@"img_src"];
            NSURL *photoURL = [[NSURL alloc] initWithString:photoString];
            [photoOutputArray addObject:photoURL];
        }

        KMLSol *solObject = [[KMLSol alloc] initWithSolID:sol.intValue photoURLs:photoOutputArray];
        [self.manifest addSol:solObject];
        completion(solObject);
    }];
    [session resume];
}

@end
