//
//  LSIFetchPhotoOperation.h
//  Astronomy
//
//  Created by David Wright on 6/7/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LSIMarsPhotoReference;

NS_SWIFT_NAME(FetchPhotoOperation)
@interface LSIFetchPhotoOperation : NSOperation

@property (nonatomic, nullable) NSURL *photoURL;
@property (nonatomic, nullable) UIImage *image;

- (nonnull instancetype)initWithPhotoURL:(nonnull NSURL *)photoURL;
+ (nonnull instancetype)fetchPhotoOperationWithMarsPhotoReference:(nonnull LSIMarsPhotoReference *)marsPhotoReference;

- (void)start;
- (void)cancel;

@end
