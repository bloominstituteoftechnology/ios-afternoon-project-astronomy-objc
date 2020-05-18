//
//  TMCMarsPhotoReference.h
//  AstronomyObjC
//
//  Created by Christopher Devito on 5/18/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMCMarsRoverCamera.h"

NS_ASSUME_NONNULL_BEGIN

@interface TMCMarsPhotoReference : NSObject
@property NSNumber *identification;
@property NSNumber *sol;
@property TMCMarsRoverCamera *camera;
@property NSDate *earthDate;
@property NSURL *imageURL;
   
-(instancetype) initWithIdentification:(NSNumber *)identification
                                   sol:(NSNumber *) sol
                                camera:(TMCMarsRoverCamera *) camera
                             earthDate:(NSDate *) earthDate
                              imageURL:(NSURL *) imageURL;
@end

NS_ASSUME_NONNULL_END
