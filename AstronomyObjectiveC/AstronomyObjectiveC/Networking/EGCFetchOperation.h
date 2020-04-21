//
//  EGCFetchOperation.h
//  AstronomyObjectiveC
//
//  Created by Enrique Gongora on 4/21/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

#import "UIKit/UIKit.h"

@class EGCMarsPhoto;

NS_ASSUME_NONNULL_BEGIN

@interface LSIFetchPhotoOperation : NSOperation

- (instancetype)initWithPhotoReference:(EGCMarsPhoto *)photoReference;

@property (nonatomic, strong, readonly) EGCMarsPhoto *photoReference;

@property (nonatomic, strong, readonly, nullable) UIImage *image;

@end

NS_ASSUME_NONNULL_END
