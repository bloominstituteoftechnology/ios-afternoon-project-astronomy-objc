//
//  JBNetworkManager.m
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-27.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import "JBNetworkManager.h"


@implementation JBNetworkManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _acceptNilData = NO;
    }
    return self;
}

- (NSURLSessionDataTask *)fetchDataWithRequest:(NSURLRequest *)request
                                    completion:(void(^)(NSData *, NSError *))completion
{
    return [NSURLSession.sharedSession
            dataTaskWithRequest:request
            completionHandler:^(NSData * _Nullable data,
                                NSURLResponse * _Nullable response,
                                NSError * _Nullable error)
    {
        if (error != nil)
        {
            completion(nil, error);
            return;
        }

        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse != nil &&
            (httpResponse.statusCode < 200 || httpResponse.statusCode > 299))
        {
            NSLog(@"Bad response: status code %li: %@",
                  (long)httpResponse.statusCode,
                  httpResponse);
            completion(nil, [[NSError alloc] init]);
            return;
        }

        if (data == nil) {
            if (self.acceptNilData) {
                completion(nil, nil);
            } else {
                NSLog(@"Error; no data");
                completion(nil, [[NSError alloc] init]);
                return;
            }
        }

        completion(data, nil);
    }];
}

- (NSURLSessionDataTask *)fetchDictionaryWithRequest:(NSURLRequest *)request
                                          completion:(void(^)(NSDictionary * _Nullable dictionary,
                                                              NSError * _Nullable error))completion
{
    return [self fetchDataWithRequest:request
                           completion:^(NSData * _Nullable data,
                                        NSError * _Nullable error)
    {
        if (error) {
            completion(nil, error);
            return;
        }
        if (data == nil) {
            NSLog(@"Error; expected data");
            completion(nil, [[NSError alloc] init]);
            return;
        }

        NSError *jsonError = nil;
        NSDictionary *dictionary = [NSJSONSerialization
                                    JSONObjectWithData:data
                                    options:0
                                    error:&jsonError];
        if (jsonError) {
            NSLog(@"Error decoding data");
            completion(nil, jsonError);
            return;
        }

        if (![dictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON was not a dictionary as expected");
            completion(nil, [[NSError alloc] init]);
            return;
        }

        completion(dictionary, nil);
    }];
}

@end
