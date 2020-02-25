//
//  CARManifestFetcher.h
//  CARAstronomy
//
//  Created by Chad Rutherford on 2/24/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CARMarsMissionManifest.h"

typedef void(^CARMainfestFetcherCompletion)(CARMarsMissionManifest *_Nullable manifest, NSError *_Nullable error);

NS_SWIFT_NAME(ManifestFetcher)
@interface CARManifestFetcher : NSObject

- (void)fetchManifestForRover:(NSString *_Nullable)rover
                   completion:(CARMainfestFetcherCompletion _Nullable)completion;

@end
