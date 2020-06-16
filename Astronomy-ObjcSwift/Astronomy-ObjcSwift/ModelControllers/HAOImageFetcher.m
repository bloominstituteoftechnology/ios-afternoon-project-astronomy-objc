//
//  HAOImageFetcher.m
//  Astronomy-ObjcSwift
//
//  Created by Hunter Oppel on 6/15/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

#import "HAOImageFetcher.h"
#import "LSIErrors.h"
#import "LSILog.h"

@implementation HAOImageFetcher

- (void)fetchImageFromURL:(NSURL *)URL completion:(HAOImageFetcherCompletion)completion
{
    // Assume https url is passed in
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        if (data == nil) {
            NSError *dataError = errorWithMessage(@"Data was nil", LSIDataNilError);
            completion(nil, dataError);
            return;
        }
        
        completion(data, nil);
    }];
    
    [task resume];
}

@end
