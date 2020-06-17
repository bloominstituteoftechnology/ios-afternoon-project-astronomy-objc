//
//  KMLFetchPhotoOperation.h
//  Astronomy_ObjectiveC
//
//  Created by Kenny on 6/16/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

NS_ASSUME_NONNULL_BEGIN


@interface KMLFetchPhotoOperation : NSOperation

@property (nonatomic) NSDictionary *cache;
@property (nonatomic) NSURL *photoURL;
@property (nonatomic, readonly) UIImage *image;

- (UIImage *)image;
- (instancetype)initWithPhotoURL:(NSURL *)photoURL session:(NSURLSession *)session;

@end

NS_ASSUME_NONNULL_END
