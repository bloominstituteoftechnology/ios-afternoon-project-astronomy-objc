//
//  ConcurrentOperation.h
//  Astronomy-ObSwiftive-c
//
//  Created by Craig Swanson on 4/27/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConcurrentOperation : NSOperation

@property (nonatomic) BOOL isReady;
@property (nonatomic) BOOL isExecuting;
@property (nonatomic) BOOL isFinished;

@property (nonatomic, copy) NSString *state;

@end

NS_ASSUME_NONNULL_END
