//
//  JLRMarsRover.h
//  Astronomy
//
//  Created by Jesse Ruiz on 12/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JLRSolDescription;

NS_SWIFT_NAME(MarsRover)
@interface JLRMarsRover : NSObject

@property (nonatomic, copy, readonly, nonnull) NSString *name;
@property (nonatomic, copy, readonly, nonnull) NSArray<JLRSolDescription *> *solDescriptions;

- (nonnull instancetype)initWithName:(nonnull NSString *)name
                     solDescriptions:(nonnull NSArray<JLRSolDescription *> *)solDescriptions;

- (nullable instancetype)initWithRoverDictionary:(nonnull NSDictionary *)roverDictionary;

@end
