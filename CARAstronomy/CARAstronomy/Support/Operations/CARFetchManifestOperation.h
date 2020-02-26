//
//  CARFetchManifestOperation.h
//  CARAstronomy
//
//  Created by Chad Rutherford on 2/25/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CARManifestFetcher.h"
#import "CARMarsMissionManifest.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(FetchManifestOperation)
@interface CARFetchManifestOperation : NSOperation

@property (nonatomic, nonnull, readonly) CARManifestFetcher *manifestFetcher;
@property (nonatomic, nullable) CARMarsMissionManifest *manifest;

- (instancetype) initWithManifestFetcher:(CARManifestFetcher *)manifestFetcher;

@end

NS_ASSUME_NONNULL_END
