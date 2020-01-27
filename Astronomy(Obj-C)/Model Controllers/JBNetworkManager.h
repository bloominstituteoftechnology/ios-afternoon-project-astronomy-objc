//
//  JBNetworkManager.h
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-27.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JBNetworkManager : NSObject

@property (nonatomic) BOOL acceptNilData;

- (instancetype)init;
- (NSURLSessionDataTask *)fetchDataWithRequest:(NSURLRequest *)request
                                    completion:(void(^)(NSData * _Nullable data,
                                                        NSError * _Nullable error))completion;
- (NSURLSessionDataTask *)fetchDictionaryWithRequest:(NSURLRequest *)request
                                          completion:(void(^)(NSDictionary * _Nullable dictionary,
                                                              NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
