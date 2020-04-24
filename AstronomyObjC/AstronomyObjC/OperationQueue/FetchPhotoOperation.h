//
//  FetchPhotoOperation.h
//  AstronomyObjC
//
//  Created by Nick Nguyen on 4/23/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Sol;


NS_ASSUME_NONNULL_BEGIN

@interface FetchPhotoOperation : NSOperation

- (instancetype)initWithPhotoReference:(Sol *)solReference;

@property (nonatomic, strong, readonly) Sol *solReference;

@property (nonatomic, strong, readonly, nullable) UIImage *image;

@end

NS_ASSUME_NONNULL_END
