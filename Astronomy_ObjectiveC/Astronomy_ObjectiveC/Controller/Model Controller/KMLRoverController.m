//
//  KMLRoverController.m
//  Astronomy_ObjectiveC
//
//  Created by Kenny on 6/15/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

#import "KMLRoverController.h"
#import "KMLManifest.h"

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
        completion(manifest);

    }];
    [session resume];
}

- (void)fetchPhotosOnSol:(int)sol
{

}

@end
