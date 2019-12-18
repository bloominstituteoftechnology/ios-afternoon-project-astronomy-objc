//
//  GIPFetchPhotoOperation.h
//  Astronomy Objc
//
//  Created by Gi Pyo Kim on 12/17/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MarsPhoto;

NS_SWIFT_NAME(FetchPhotoOperation)
@interface GIPFetchPhotoOperation : NSOperation

@property (readonly, nullable) UIImage *image;

- (nonnull instancetype)initWithPhotoRef:(nonnull MarsPhoto *)photoRef;

@end

