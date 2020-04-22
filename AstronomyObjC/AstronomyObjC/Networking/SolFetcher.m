//
//  SolFetcher.m
//  AstronomyObjC
//
//  Created by Nick Nguyen on 4/21/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

#import "SolFetcher.h"
#import "Sol.h"
#import "SolCamera.h"
#import "LSILog.h"
#import "LSIErrors.h"
#import "LSIFileHelper.h"
#import "SolArrayResult.h"

static NSString *baseURLString = @"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&page=2&api_key=HawdkeoyrsCNZTu0DtPL4loF7dhLOOj259yzrktr";


static NSString *const baseURLOfString = @"https://api.nasa.gov/mars-photos/api/v1/rovers";
static NSString *const apiKey = @"HawdkeoyrsCNZTu0DtPL4loF7dhLOOj259yzrktr";

@implementation SolFetcher

- (instancetype)init {
    self = [super init];
    if (self ) {
        
    }
    return self;
}
- (void)fetchExampleSol:(SolFetcherCompletionBlock)completionBlock {
    NSURL *url = [NSURL URLWithString:baseURLString];
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completionBlock(nil,error);
            return;
        }
        if (!data) {
            NSError *dataError = errorWithMessage(@"No data in URL response for quakes", LSIDataNilError);
            completionBlock(nil,dataError);
            return;
        }
        NSError *jsonError = nil;
      
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            completionBlock(nil,jsonError);
            return;
        }
        
        SolArrayResult *solResult = [[SolArrayResult alloc]initWithDictionary:json];
        completionBlock(solResult.solArray,nil);
        
        
    }];
    [task resume];
}


- (void)fetchPhotosForRover:(NSString *)rover
                    withSol:(NSNumber *)sol
                 completion:(SolFetcherCompletionBlock)completionBlock {
    
    NSURL *baseURL = [[[NSURL URLWithString:baseURLOfString] URLByAppendingPathComponent:rover]
                      URLByAppendingPathComponent:@"photos"];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"sol" value:[NSString stringWithFormat:@"%d",sol.intValue]],
        [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey]
        
    ];
    NSURL *url = urlComponents.URL;
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(nil,error);
            });
            return;
        }
        NSLog(@"%@",url);
        if (!data) {
            NSError *dataError = errorWithMessage(@"No data", LSIDataNilError);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(nil,dataError);
            });
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(nil,jsonError);
            });
            return;
        }
        NSArray *photosArray = json[@"photos"];
        NSMutableArray *photos = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in photosArray) {
            Sol *sol = [[Sol alloc] initWithDictionary:dictionary];
            [photos addObject:sol];
        }
        if (!photos) {
            NSError *parsingError = errorWithMessage(@"Error parsing json", LSIJSONDecodeError);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(nil,parsingError);
            });
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(photos,nil);
        });
        
    
    }] resume];
    
    
    
}

@end
