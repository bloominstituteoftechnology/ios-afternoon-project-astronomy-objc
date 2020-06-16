//
//  HAOImageFetcher.h
//  Astronomy-ObjcSwift
//
//  Created by Hunter Oppel on 6/15/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HAOImageFetcherCompletion)(NSData * _Nullable data, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(ImageFetcher)

@interface HAOImageFetcher : NSObject

- (void)fetchImageFromURL:(NSURL *)URL completion:(HAOImageFetcherCompletion)completion;

@end

NS_ASSUME_NONNULL_END
