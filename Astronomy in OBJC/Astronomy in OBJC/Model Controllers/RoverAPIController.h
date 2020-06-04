//
//  RoverAPIController.h
//  Astronomy in OBJC
//
//  Created by Sal B Amer on 6/4/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

#import <Foundation/Foundation.h>

//fwd class declaration for MarsRoverModel
@class MarsRover;

NS_ASSUME_NONNULL_BEGIN

@interface RoverAPIController : NSObject

@property (nonatomic, readonly, copy) NSArray<MarsRover *> *solPhotos;

@end

NS_ASSUME_NONNULL_END
