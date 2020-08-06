//
//  FetchManifest.h
//  Astronomy-objc
//
//  Created by Matthew Martindale on 8/5/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Rover;


typedef void(^FetchRoverManifestCompletionHandler)(Rover *_Nullable marsRover, NSError *_Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface FetchManifest : NSObject

-(void)fetchRoverManifest:(NSString *)roverName
        completionHandler:(FetchRoverManifestCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
