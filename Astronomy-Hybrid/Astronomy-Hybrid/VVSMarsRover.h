//
//  VVSMarsRover.h
//  Astronomy-Hybrid
//
//  Created by Vici Shaweddy on 2/12/20.
//  Copyright © 2020 Vici Shaweddy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VVSSolDescription.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(MarsRover)
@interface VVSMarsRover : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSDate *launchDate;
@property (nonatomic, readonly) NSDate *landingDate;

typedef NS_ENUM(NSInteger, Status) {
    Active,
    Complete
};

@property (nonatomic, readonly) Status status;

@property (nonatomic, readonly) NSInteger maxSol;
@property (nonatomic, readonly) NSDate *maxDate;

@property (nonatomic, readonly) NSInteger numberOfPhotos;

@property (nonatomic, readonly) NSArray<VVSSolDescription *> *solDescription;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
