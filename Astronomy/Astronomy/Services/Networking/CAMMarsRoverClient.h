//
//  CAMMarsRoverClient.h
//  Astronomy
//
//  Created by Cody Morley on 7/20/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//
#import <Foundation/Foundation.h>
@class CAMMarsRover;
@class CAMMarsPhoto;

typedef void (^roverCompletion) (CAMMarsRover *_Nullable, NSError *_Nullable);
typedef void (^photoCompletion) (NSMutableArray<CAMMarsPhoto *>*_Nullable, NSError *_Nullable);
typedef void (^fetchCompletion) (id _Nullable, NSError  *_Nullable);

NS_ASSUME_NONNULL_BEGIN

@interface CAMMarsRoverClient : NSObject
//MARK: Actions
- (void)fetchMarsRoverNamed:(NSString *)name
                    session:(NSURLSession *)session
                 completion:(roverCompletion)completion;

- (void)fetchPhotosFromRover:(CAMMarsRover *)rover
                         sol:(int)sol
                     session:(NSURLSession *)session
                  completion:(photoCompletion)completion;

@end

NS_ASSUME_NONNULL_END
