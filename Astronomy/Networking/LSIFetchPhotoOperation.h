//
//  LSIFetchPhotoOperation.h
//  Astronomy
//
//  Created by Andrew R Madsen on 11/28/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSIMarsPhoto;

NS_ASSUME_NONNULL_BEGIN

@interface LSIFetchPhotoOperation : NSOperation

- (instancetype)initWithPhotoReference:(LSIMarsPhoto *)photoReference;

@property (nonatomic, strong, readonly) LSIMarsPhoto *photoReference;

@property (nonatomic, strong, readonly, nullable) UIImage *image;

@end

NS_ASSUME_NONNULL_END
