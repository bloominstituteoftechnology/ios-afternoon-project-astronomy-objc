//
//  SKSRoverController.h
//  Astronomy-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKSMarsRover;

NS_SWIFT_NAME(RoverController)

@interface SKSRoverController : NSObject

@property (nonatomic, nonnull) SKSMarsRover *marsRover;

- (void)photoManifestForRover:(nonnull void (^)(NSError * _Nullable))completion;
- (void)photosForRoverOnSol:(nonnull NSString *)sol completion:(nonnull void (^)(NSError *_Nullable))completion;

@end

