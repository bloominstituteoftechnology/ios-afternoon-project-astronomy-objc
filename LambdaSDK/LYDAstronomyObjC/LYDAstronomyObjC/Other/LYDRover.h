//
//  LYDRover.h
//  LYDAstronomyObjC
//
//  Created by Lydia Zhang on 5/18/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class LYDSol;

@interface LYDRover : NSObject
@property int numberOfPhotos;
@property NSString *name;
@property NSDate *launchDate;
@property NSDate *landingDate;
@property int maxSol;
@property NSString *status;
@property NSDate *maxDate;
@property NSArray<LYDSol *> *solArray;

- (instancetype)initWithDictionary: (NSDictionary *)roverDictionary;

@end

NS_ASSUME_NONNULL_END
