//
//  CARSolFetcher.h
//  CARAstronomy
//
//  Created by Chad Rutherford on 2/24/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CARSolFetcherCompletion) (NSArray * _Nullable sols, NSError *_Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface CARSolFetcher : NSObject

- (void)fetchPhotosForRover:(NSString *)rover
                    withSol:(NSNumber *)sol
               completion:(CARSolFetcherCompletion)completion;

@end

NS_ASSUME_NONNULL_END
