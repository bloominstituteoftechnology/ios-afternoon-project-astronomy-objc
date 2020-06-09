//
//  LSIFetchPhotoOperation.h
//  Astronomy
//
//  Created by David Wright on 6/7/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSIMarsPhotoReference;

NS_SWIFT_NAME(FetchPhotoOperation)
@interface LSIFetchPhotoOperation : NSOperation

@property (nonatomic, readonly, nonnull) LSIMarsPhotoReference *marsPhotoReference;
@property (nonatomic, copy, nullable) NSData *imageData;

- (nonnull instancetype)initWithMarsPhotoReference:(nonnull LSIMarsPhotoReference *)marsPhotoReference;

- (void)start;
- (void)cancel;

@end
