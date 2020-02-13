//
//  VVSMarsRoverClient.h
//  Astronomy-Hybrid
//
//  Created by Vici Shaweddy on 2/12/20.
//  Copyright © 2020 Vici Shaweddy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VVSMarsRover.h"

NS_ASSUME_NONNULL_BEGIN

@class MarsPhotoReference;

NS_SWIFT_NAME(MarsRoverClient)
@interface VVSMarsRoverClient : NSObject

- (void)fetchMarsRoverWithName:(NSString *)name
                       session:(NSURLSession * _Nullable)session
                    completion:(void (^)(VVSMarsRover * _Nullable marsRover, NSError * _Nullable error))completion;

- (void)fetchPhotosFrom:(VVSMarsRover *)rover
                  onSol:(NSInteger)sol
                session:(NSURLSession * _Nullable)session
             completion:(void (^)(NSArray<MarsPhotoReference *> * _Nullable marsPhotoReference, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
