//
//  CAMMarsRover.h
//  Astronomy
//
//  Created by Cody Morley on 7/20/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CAMSolDescription.h"


NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(MarsRover)

@interface CAMMarsRover : NSObject


@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSDate *launchDate;
@property (nonatomic, readonly, copy) NSDate *landingDate;
@property (nonatomic, readonly, copy) NSString *status;
@property (nonatomic, readonly) int maxSol;
@property (nonatomic, readonly, copy) NSDate *maxDate;
@property (nonatomic, readonly) int numberOfPhotos;
@property (nonatomic, readonly, copy) NSArray <CAMSolDescription *> *solDescriptions;
@property (nonatomic) NSDateFormatter *dateFormatter;

- (instancetype)initWithName:(NSString *)name
                  launchDate:(NSDate *)launchDate
                 landingDate:(NSDate *)landingDate
                      status:(NSString *)status
                      maxSol:(int)maxSol
                     maxDate:(NSDate *)maxDate
              numberOfPhotos:(int)numberOfPhotos
             solDescriptions:(NSArray <CAMSolDescription *> *)solDesriptions;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (void)setupDateFormatter;

NS_ASSUME_NONNULL_END
@end




