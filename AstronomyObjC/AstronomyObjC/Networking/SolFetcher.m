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
@implementation SolFetcher

- (instancetype)init {
    self = [super init];
    if (self ) {
        
    }
    return self;
}
- (void)fetchOneSingleSol:(SolFetcherCompletionBlock)completionBlock {
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

@end
