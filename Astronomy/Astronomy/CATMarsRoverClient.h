//
//  CATMarsRoverClient.h
//  Astronomy
//
//  Created by Jessie Ann Griffin on 6/5/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CATMarsPhoto.h"
#import "Astronomy-Swift.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^MarsRoverCompletion)(CATMarsRover * _Nullable rover, NSError * _Nullable error);
typedef void (^MarsPhotosCompletion)(NSArray <CATMarsPhoto *> * _Nullable photos, NSError * _Nullable error);
typedef void (^GenericCompletion)(id _Nullable * _Nullable object, NSError * _Nullable error);

NS_SWIFT_NAME(MarsRoverClient)
@interface CATMarsRoverClient : NSObject

- (void)fetchMarsRoverWithName:(NSString *)roverName completion:(MarsRoverCompletion)completion;

- (void)saveMarsRoverToLocal:(MarsRoverCompletion)completion;

- (void)fetchPhotosFrom:(CATMarsRover *)rover onSol:(int)sol completion:(MarsPhotosCompletion)completion;

- (void)fetchLocalPhotosFrom:(CATMarsRover *)rover onSol:(int)sol completion:(MarsPhotosCompletion)completion;

@end

NS_ASSUME_NONNULL_END
