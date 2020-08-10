//
//  FetchManifest.h
//  Astronomy-objc
//
//  Created by Matthew Martindale on 8/5/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MarsPhotoReference.h"

@class Rover;
@class MarsPhotoReference;

typedef void(^FetchRoverManifestCompletionHandler)(Rover *_Nullable marsRover, NSError *_Nullable error);
typedef void(^FetchMarsPhotosCompletionHandler)(NSArray<MarsPhotoReference *> *_Nullable photos, NSError *_Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface FetchManifest : NSObject

-(void)fetchRoverManifest:(NSString *)roverName
        completionHandler:(FetchRoverManifestCompletionHandler)completionHandler;

- (void)fetchPhotosFromRover:(nonnull Rover *)marsRover
                       onSol:(int)sol
           completionHandler:(FetchMarsPhotosCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
