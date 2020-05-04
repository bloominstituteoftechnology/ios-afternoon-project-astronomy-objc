//
//  LSIMarsRover.h
//  Astronomy
//
//  Created by Andrew R Madsen on 10/8/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SolDescription;

typedef NS_ENUM(NSInteger, LSIMarsRoverStatus) {
	LSIMarsRoverStatusActive,
	LSIMarsRoverStatusComplete,
};

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(MarsRover)
@interface LSIMarsRover : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, strong, readonly) NSString *name;

@property (nonatomic, strong, readonly) NSDate *launchDate;
@property (nonatomic, strong, readonly) NSDate *landingDate;

@property (nonatomic, readonly) LSIMarsRoverStatus status;

@property (nonatomic, readonly) NSInteger maxSol;
@property (nonatomic, strong, readonly) NSDate *maxDate;

@property (nonatomic, readonly) NSInteger numberOfPhotos;

@property (nonatomic, strong, readonly) NSArray<SolDescription *> *solDescriptions;

@end

NS_ASSUME_NONNULL_END
