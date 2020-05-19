//
//  TMCNetworkController.m
//  AstronomyObjC
//
//  Created by Christopher Devito on 5/18/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import "TMCNetworkController.h"
#import "AstronomyObjC-Swift.h"
#import "NSObject+NSJSONSerialization.h"
#import "TMCMarsPhotoReference.h"
#import "NSURL+TMCUsingHTTPS.h"

@implementation TMCNetworkController

static NSString *apiKey = @"IjCchzjn0EuNgmVSr824DPsW57IXpXMwg7bS9mnc";

- (instancetype)initWithPhotos:(NSMutableArray *)photos
{
    self = [super init];
    if (self) {
        _photos = photos;
    }
    return self;
}

- (void)fetchMarsPhotosOnSol:(NSNumber *)sol
             completionBlock:(TMCMarsPhotoCompletion)completionBlock {

    NSURL *baseURL = [NSURL URLWithString:@"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos"];
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    NSURLQueryItem *solTerm = [NSURLQueryItem queryItemWithName:@"sol" value:[NSString stringWithFormat:@"%i", sol.intValue]];
    NSURLQueryItem *page = [NSURLQueryItem queryItemWithName:@"page" value:[NSString stringWithFormat:@"%i", 1]];
    NSURLQueryItem *apiKeyQuery = [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey];
    components.queryItems = @[solTerm, page, apiKeyQuery];
    NSURL *url = components.URL;

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

- (void)fetchImageForPhotoReference:(TMCMarsPhotoReference *)photoReference  completionBlock: (TMCMarsSinglePhotoCompletion)completionBlock {
    NSURL *url = photoReference.imageURL.usingHTTPS;

    NSURLSessionTask *task = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completionBlock(nil, error);
            return;
        }

        if (!data) {
            completionBlock(nil, [[NSError alloc] init]);
            return;
        }

        completionBlock(data, nil);
        return;
    }];
    [task resume];
}

@end
