//
//  MJRMarsRoverClient.h
//  Astronomy-Objc
//
//  Created by Marlon Raskin on 10/14/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MJRMarsRover;

NS_SWIFT_NAME(MarsRoverClient)
NS_ASSUME_NONNULL_BEGIN

@interface MJRMarsRoverClient : NSObject

- (NSURL *)urlForRoverInfo:(NSString *)roverName;
- (NSURL *)urlForPhotosFromRover:(NSString *)roverName andSol:(int)sol;
- (void)fetchRoverNamed:(NSString *)roverName completion:(void (^)(MJRMarsRover *_Nullable rover, NSError *_Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
