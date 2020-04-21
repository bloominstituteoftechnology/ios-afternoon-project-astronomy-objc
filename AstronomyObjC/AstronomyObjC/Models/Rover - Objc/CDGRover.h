//
//  CDGRover.h
//  AstronomyObjC
//
//  Created by Chris Gonzales on 4/21/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Sol;

typedef NS_ENUM(NSInteger, CDGRoverStatus) {
    CDGRoverStatusActive,
    CDGRoverStatusComplete,
};

NS_ASSUME_NONNULL_BEGIN

@interface CDGRover : NSObject

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSDate *launchDate;
@property (nonatomic, strong, readonly) NSDate *landingDate;
@property (nonatomic, readonly) CDGRoverStatus status;
@property (nonatomic, readonly) NSInteger maxSol;
@property (nonatomic, strong, readonly) NSDate *maxDate;
@property (nonatomic, readonly) NSInteger numberOfPhotos;
@property (nonatomic, strong, readonly) NSArray<Sol *> *sols;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
