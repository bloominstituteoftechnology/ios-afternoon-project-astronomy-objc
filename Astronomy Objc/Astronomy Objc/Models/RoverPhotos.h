//
//  RoverPhotos.h
//  Astronomy Objc
//
//  Created by Vincent Hoang on 7/20/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Rover;

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(RoverPhotos)

@interface RoverPhotos : NSObject

@property (nonatomic, readonly) NSNumber *photoId;
@property (nonatomic, readonly) NSNumber *sol;
@property (nonatomic, readonly, copy) NSString *img_src;
@property (nonatomic, readonly, copy) NSString *earth_date;
@property (nonatomic, readonly) Rover *rover;

@end

NS_ASSUME_NONNULL_END
