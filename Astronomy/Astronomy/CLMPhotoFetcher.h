//
//  CLMPhotoFetcher.h
//  Astronomy
//
//  Created by Claudia Maciel on 8/7/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLMPhoto;

typedef void (^CLMPhotoFetcherCompletion)(NSArray<CLMPhoto *> * _Nullable photos, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(PhotoFetcher)

@interface CLMPhotoFetcher : NSObject

- (void)fetchPhotosFromSol:(NSNumber *)sol completion:(CLMPhotoFetcherCompletion)completion;

@end

NS_ASSUME_NONNULL_END
