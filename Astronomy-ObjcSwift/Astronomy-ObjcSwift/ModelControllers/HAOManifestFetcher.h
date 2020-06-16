//
//  HAOManifestFetcher.h
//  Astronomy-ObjcSwift
//
//  Created by Hunter Oppel on 6/16/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HAOManifestFetcherCompletion)(NSArray<NSNumber *> * _Nullable sols, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(ManifestFetcher)

@interface HAOManifestFetcher : NSObject

- (void)fetchManifestWithCompletion:(HAOManifestFetcherCompletion)completion;

@end

NS_ASSUME_NONNULL_END
