//
//  JLCPhotoController.h
//  iOS9-Astronomy
//
//  Created by Jake Connerly on 11/12/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JLCMarsRover.h"
#import "JLCMarsPhoto.h"

NS_ASSUME_NONNULL_BEGIN

@interface JLCPhotoController : NSObject

@property (nonatomic, readonly) JLCMarsRover *rover;

@property (nonatomic) NSArray *photos;

- (void)fetchPhotosfromSol:(double)sol
                  completion:(void (^)(JLCMarsPhoto *photo, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
