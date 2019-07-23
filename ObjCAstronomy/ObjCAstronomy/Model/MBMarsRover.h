//
//  MBMarsRover.h
//  ObjCAstronomy
//
//  Created by Mitchell Budge on 7/23/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBMarsRover : NSObject

@property NSString *name;
@property NSDate *launchDate;
@property NSDate *landingDate;
@property NSInteger maxSol;
@property NSDate *maxDate;
@property NSInteger numberOfPhotos;
@property NSArray<SolDescription *> *solDescriptions;

@end

NS_ASSUME_NONNULL_END
