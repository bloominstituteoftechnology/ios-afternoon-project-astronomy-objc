//
//  HAOPhotoFetcher.h
//  Astronomy-ObjcSwift
//
//  Created by Hunter Oppel on 6/15/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HAOPhoto;

typedef void (^HAOPhotoFetcherCompletion)(NSArray<HAOPhoto *> * _Nullable photos, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(PhotoFetcher)

@interface HAOPhotoFetcher : NSObject

- (void)fetchPhotosFromSol:(NSNumber *)sol completion:(HAOPhotoFetcherCompletion)completion;

@end

NS_ASSUME_NONNULL_END
