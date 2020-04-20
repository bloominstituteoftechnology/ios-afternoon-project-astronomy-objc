//
//  TXCMarsRoverClient.h
//  AstronomyObjc
//
//  Created by Thomas Cacciatore on 7/22/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TXCMarsRoverClient : NSObject

typedef void (^TXCManifestFetcherCompletionBlock)(NSArray *, NSError *);

- (void)fetchPhotoManifestCompletionBlock:(TXCManifestFetcherCompletionBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END
