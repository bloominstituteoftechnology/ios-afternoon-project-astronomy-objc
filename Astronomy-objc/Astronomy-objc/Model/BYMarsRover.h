//
//  MarsRover.h
//  Astronomy-objc
//
//  Created by Bradley Yin on 10/14/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYSolDescription.h"


//typedef NS_ENUM (NSInteger, Status) {active, complete};

@interface BYMarsRover : NSObject

@property NSString *name;
@property NSDate *launchDate;
@property NSDate *landingDate;
@property NSString *status;
@property NSNumber *maxSol;
@property NSDate *maxDate;
@property NSNumber *numberOfPhotos;
@property NSArray<BYSolDescription *> *solDescriptions;
@property (nonatomic) NSDateFormatter *dateFormatter;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

