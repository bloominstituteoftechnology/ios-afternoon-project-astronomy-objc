//
//  CDGFetchPhoto.h
//  AstronomyObjC
//
//  Created by Chris Gonzales on 4/21/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDGPhoto;

NS_ASSUME_NONNULL_BEGIN

@interface CDGFetchPhoto : NSObject

@property (nonatomic, strong, readonly) CDGPhoto *photo;
@property (nonatomic, strong, readonly, nullable) UIImage *image;

- (instancetype)initWithPhoto:(CDGPhoto *)photo;

@end

NS_ASSUME_NONNULL_END
