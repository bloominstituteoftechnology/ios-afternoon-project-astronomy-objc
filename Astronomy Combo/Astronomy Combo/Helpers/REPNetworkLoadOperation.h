//
//  REPNetworkLoadOperation.h
//  Astronomy Combo
//
//  Created by Michael Redig on 10/15/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface REPNetworkLoadOperation : NSOperation

@property (nonatomic, readonly) NSURL *url;
@property (nonatomic, readonly, nullable) NSData *loadedData;

- (instancetype)initWithURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
