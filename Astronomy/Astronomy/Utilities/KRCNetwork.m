//
//  KRCNetwork.m
//  Astronomy
//
//  Created by Christopher Aronson on 7/22/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

#import "KRCNetwork.h"

@implementation KRCNetwork

- (void)NetworkCallForURL:(NSURL *)url completion: (KRCNetworkCompletion)completion {
    
    NSURLSessionTask *networkTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            completion(nil, error);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            completion(nil, jsonError);
            return;
        }
        
        completion(json, nil);
        
    }];
    
    [networkTask resume];
}

@end
