//
//  SKSRoverController.h
//  Astronomy-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SolDescription;

NS_SWIFT_NAME(RoverController)

@interface SKSRoverController : NSObject

- (nonnull NSArray<SolDescription *> *)getSolDescriptions;
- (void)photoManifestForRover:(nonnull void (^)(NSError * _Nullable))completion;
- (void)photosForRoverOnSol:(nonnull NSString *)sol completion:(nonnull void (^)(NSError *_Nullable))completion;

@end

