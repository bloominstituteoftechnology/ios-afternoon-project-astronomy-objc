//
//  ConcurrentOperation.h
//  Astronomy-ObSwiftive-c
//
//  Created by Craig Swanson on 4/27/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class RoverPhoto;

NS_ASSUME_NONNULL_BEGIN

@interface FetchPhotoOperation : NSOperation

@property (nonatomic, strong) RoverPhoto *roverPhotoReference;
@property (nonatomic, strong) UIImage *roverPhoto;
@property (nonatomic) BOOL isFinished;
@property (nonatomic) BOOL isExecuting;

- (instancetype)initWithRoverPhotoReference:(RoverPhoto *) roverPhotoReference;

@end

NS_ASSUME_NONNULL_END
