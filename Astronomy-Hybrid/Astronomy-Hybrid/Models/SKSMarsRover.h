//
//  SKSMarsRover.h
//  Astronomy-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SolDescription;

NS_SWIFT_NAME(MarsRover)

@interface SKSMarsRover : NSObject

@property (nonatomic, nonnull) NSString *name;
@property (nonatomic, nonnull) NSDate *landingDate;
@property (nonatomic, nonnull) NSDate *launchDate;
@property (nonatomic) int maxSol;
@property (nonatomic) int totalPhotos;
@property (nonatomic, readonly, nonnull) NSArray<SolDescription *> *solDescriptions;

- (instancetype _Nullable)initWithName:(nonnull NSString *)name
                 landingDate:(nonnull NSDate *)landingDate
                  launchDate:(nonnull NSDate *)launchDate
                      maxSol:(int)maxSol
                 totalPhotos:(int)totalPhotos
             solDescriptions:(nonnull NSArray<SolDescription *> *)solDescriptions;

- (instancetype _Nullable)initWithDictionary:(nullable NSDictionary *)dictionary;

@end

