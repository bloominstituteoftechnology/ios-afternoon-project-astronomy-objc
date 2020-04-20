//
//  VVSPhotoFetchOperation.h
//  Astronomy-Hybrid
//
//  Created by Vici Shaweddy on 2/16/20.
//  Copyright © 2020 Vici Shaweddy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(PhotoFetchOperation)
@interface VVSPhotoFetchOperation : NSOperation

@property (nonatomic) UIImage * _Nullable photo;

- (instancetype)initWithURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
