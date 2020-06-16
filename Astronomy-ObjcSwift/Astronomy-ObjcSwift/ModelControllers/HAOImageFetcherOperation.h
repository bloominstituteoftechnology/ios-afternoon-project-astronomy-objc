//
//  HAOImageFetcherOperation.h
//  Astronomy-ObjcSwift
//
//  Created by Hunter Oppel on 6/16/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(ImageFetcherOperation)

@interface HAOImageFetcherOperation : NSOperation

@property NSURL *URL;
@property NSData *imageData;

- (instancetype)initWithURL:(NSURL *)URL;

@end

NS_ASSUME_NONNULL_END
