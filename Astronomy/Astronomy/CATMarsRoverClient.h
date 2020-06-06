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

typedef void (^MarsRoverCompletion)(CATMarsRover *rover, NSError *error);
typedef void (^MarsPhotosCompletion)(NSArray <CATMarsPhoto *> *photos, NSError *error);

NS_SWIFT_NAME(MarsRoverClient)
@interface CATMarsRoverClient : NSObject

- (void)fetchMarsRoverWithName:(NSString *)name usingSession:(NSURLSession *)session completion:(MarsRoverCompletion)completion;

- (void)saveMarsRoverToLocal:(MarsRoverCompletion)completion;

- (void)fetchPhotosFrom:(CATMarsRover *)rover onSol:(int)sol usingSession:(NSURLSession *)session completion:(MarsPhotosCompletion)photos;

- (void)fetchLocalPhotosFrom:(CATMarsRover *)rover onSol:(int)sol completion:(MarsPhotosCompletion)photos;

@end

NS_ASSUME_NONNULL_END
