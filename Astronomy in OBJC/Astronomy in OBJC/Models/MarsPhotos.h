//
//  MarsPhotos.h
//  Astronomy-in-OBJC
//
//  Created by Sal B Amer on 6/4/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MarsRoverCamera.h"

NS_ASSUME_NONNULL_BEGIN

@interface MarsPhotos : NSObject

@property NSNumber *identification;
@property NSNumber *sol;
@property NSString *camera;
@property NSString *earthDate;
@property NSURL *imageURL;

-(instancetype)initWithIdentification:(NSNumber *) identification
                                  sol:(NSNumber *) sol
                               camera:(NSString *) camera
                            earthDate:(NSString *) earthDate
                             imageURL:(NSURL *) imageURL;


@end

NS_ASSUME_NONNULL_END
