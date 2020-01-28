//
//  JBFetchOperation.h
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-28.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JBFetchOperation : NSOperation

@property (nonatomic, nullable, readonly) UIImage *image;
@property (nonatomic, nullable, readonly) NSError *error;
- (instancetype) initWithRequest:(NSURLRequest *)request;

@end

NS_ASSUME_NONNULL_END
