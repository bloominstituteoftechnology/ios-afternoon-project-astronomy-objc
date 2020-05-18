//
//  WHLPhotoController.m
//  Astronomy
//
//  Created by Karen Rodriguez on 5/18/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

#import "WHLPhotoController.h"
#import <UIKit/UIKit.h>
#import "Astronomy-Bridging-Header.h"


NSString *baseURLString = @"https://api.nasa.gov/mars-photos/api/v1/";
NSString *apiKey = @"3MYY5NPWds1kZu7B3B7In88FKEHYXncJQkgBFNr6";

@implementation WHLPhotoController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _photos = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)fetchSinglePhotoWithURL:(NSURL *)imgSrc
                 completionBlock:(void (^)(NSError * _Nullable error, UIImage * _Nullable image))completionBlock{

    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:imgSrc completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Inside of datatask completionHandler with url: %@", imgSrc);

        if (error) {
            completionBlock(error, nil);
            return;
        }

        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            completionBlock(nil, image);
            return;
        }
    }];

    [task resume];
}

- (void)fetchManifest:(void (^)(NSError * _Nullable))completionBlock {

    NSURL *baseURL = [[NSURL URLWithString:baseURLString] URLByAppendingPathComponent:@"manifests/curiosity"];

    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:NO];

    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey]
    ];


    NSURL *requestURL = urlComponents.URL;

    NSURLSessionTask *task = [NSURLSession.sharedSession dataTaskWithURL:requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Inside of fetchManifest method with url: %@", requestURL);

        if (error) {
            completionBlock(error);
            return;
        }
    }];

    [task resume];
}
@end