//
//  FetchPhotoOperation.h
//  Astronomy-objc
//
//  Created by Bradley Yin on 10/15/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BYMarsPhotoReference;
//typedef NS_ENUM (NSInteger, State) {isReady, isExeciting, isFinished};

@interface FetchPhotoOperation : NSOperation

- (instancetype)initWithPhotoReference:(BYMarsPhotoReference *)photoReference;

@end

