//
//  LSIMarsRover.h
//  Astronomy
//
//  Created by David Wright on 6/3/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSISolDescription;

NS_SWIFT_NAME(MarsRover)
@interface LSIMarsRover : NSObject

@property (nonatomic, copy, readonly, nonnull) NSString *name;
@property (nonatomic, readonly) int numberOfPhotos;
@property (nonatomic, readonly) int maxSol;
@property (nonatomic, copy, readonly, nonnull) NSArray<LSISolDescription *> *solDescriptions;

// Unused API values
/*
@property (nonatomic, readonly, nonnull) NSDate *landingDate;       // API key: "landing_date"
@property (nonatomic, readonly, nonnull) NSDate *launchDate;        // API key: "launch_date"
@property (nonatomic, copy, readonly, nonnull) NSString *status;    // API key: "status"
*/

- (nonnull instancetype)initWithName:(nonnull NSString *)name
                      numberOfPhotos:(int)numberOfPhotos
                              maxSol:(int)maxSol
                     solDescriptions:(nonnull NSArray<LSISolDescription *> *)solDescriptions;

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end
