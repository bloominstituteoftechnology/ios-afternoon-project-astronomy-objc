//
//  SKSRoverController.h
//  Astronomy-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKSMarsRover, SKSPhotoReference;

NS_SWIFT_NAME(RoverController)

@interface SKSRoverController : NSObject

- (void)photoManifestForRover:(nonnull void (^)(SKSMarsRover *_Nullable, NSError * _Nullable))completion;
- (void)photosForRoverOnSol:(NSInteger)sol completion:(nonnull void (^)(NSArray<SKSPhotoReference *> *_Nullable, NSError *_Nullable))completion;

@end

