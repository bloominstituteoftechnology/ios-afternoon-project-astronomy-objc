//
//  MarsRoverManifestController.h
//  Astronomy-objc
//
//  Created by Dillon P on 4/27/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MissionManifestCompletionHandler)(NSDictionary *_Nullable photoManifest, NSError *_Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface MarsRoverManifestController : NSObject

- (void)fetchMissionManifestWithCompletionHandler:(MissionManifestCompletionHandler)completionHandler;


@end

NS_ASSUME_NONNULL_END
