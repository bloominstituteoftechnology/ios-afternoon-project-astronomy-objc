//
//  TMCNetworkController.m
//  AstronomyObjC
//
//  Created by Christopher Devito on 5/18/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import "TMCNetworkController.h"

@implementation TMCNetworkController

static NSString *apiKey = @"IjCchzjn0EuNgmVSr824DPsW57IXpXMwg7bS9mnc";

@end


//- (void)fetchArtistWithName:(NSString *)name
//completionBlock:(CBDArtistCompletion)completionBlock {
//
//    NSURL *baseURL = [NSURL URLWithString:baseURLString];
//    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
//    NSURLQueryItem *searchTerm = [NSURLQueryItem queryItemWithName:@"s" value:name];
//    components.queryItems = @[searchTerm];
//    NSURL *url = components.URL;
//
//    if (!url) {
//        return;
//    }
//
//    NSURLSessionTask *task = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//        if (error) {
//            completionBlock(nil, error);
//            return;
//        }
//
//        if (!data) {
//            NSLog(@"No data from network");
//            completionBlock(nil, nil);
//            return;
//        }
//
//        NSError *jsonError = nil;
//        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
//
//        if (jsonError) {
//            completionBlock(nil, jsonError);
//            return;
//        }
//
//        CBDArtist *artist = [[CBDArtist alloc] initWithDictionary:dictionary];
//        if (artist) {
//            completionBlock(artist, nil);
//            return;
//        }
//        completionBlock(nil, nil);
//    }];
//    [task resume];
//}
