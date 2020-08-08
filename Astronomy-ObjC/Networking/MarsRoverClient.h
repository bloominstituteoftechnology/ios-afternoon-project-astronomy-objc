//
//  MarsRoverClient.h
//  Astronomy-ObjC
//
//  Created by Chad Parker on 8/7/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MarsRover;

typedef void(^FetchMarsRoverCompletionHandler)(MarsRover *_Nullable quakes, NSError *_Nullable error);

@interface MarsRoverClient : NSObject

- (void)fetchMarsRoverNamed:(nonnull NSString *)name completion:(nonnull FetchMarsRoverCompletionHandler)completion;

@end
