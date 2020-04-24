//
//  SolFetcher.h
//  AstronomyObjC
//
//  Created by Nick Nguyen on 4/21/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Sol;
typedef void (^SolFetcherCompletionBlock)(NSArray<Sol *>* _Nullable sols, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface SolFetcher : NSObject
- (void)fetchExampleSol:(SolFetcherCompletionBlock)completionBlock;


- (void)fetchPhotosForRover:(NSString *)rover
                    withSol:(NSNumber *)sol
                 completion:(SolFetcherCompletionBlock)completionBlock;


@end
NS_ASSUME_NONNULL_END
