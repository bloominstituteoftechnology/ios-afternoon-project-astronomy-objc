//
//  CAMMarsRoverClient.h
//  Astronomy
//
//  Created by Cody Morley on 7/20/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CAMMarsRover.h"
#import "CAMSolDescription.h"
#import "CAMCamera.h"
#import "CAMMarsRoverClient.h"
#import "Astronomy-Swift.h"

NS_ASSUME_NONNULL_BEGIN

typedef (^roverCompletion) (CAMMarsRover *, NSError *);

@interface CAMRoverClient : NSObject

- (void)fetchMarsRoverNamed:(NSString *)name session:(NSURLSession *)session completion:(roverCompletion)


@end

NS_ASSUME_NONNULL_END
