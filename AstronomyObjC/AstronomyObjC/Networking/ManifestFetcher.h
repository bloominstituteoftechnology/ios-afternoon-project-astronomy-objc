//
//  ManifestFetcher.h
//  AstronomyObjC
//
//  Created by Nick Nguyen on 4/22/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SolManifest.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^ManifestFetcherCompletion)(SolManifest *_Nullable manifest,NSError *_Nullable error);

@interface ManifestFetcher : NSObject

- (void)fetchManifestForRover:(NSString *_Nullable)rover completion:(ManifestFetcherCompletion _Nullable)completion;


@end

NS_ASSUME_NONNULL_END
