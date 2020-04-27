//
//  Rover.h
//  Astronomy-objc
//
//  Created by Dillon P on 4/26/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Camera.h"

NS_ASSUME_NONNULL_BEGIN

@interface Rover : NSObject

@property (nonatomic, readonly) int identifier; // just "id" from the api
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly) NSDate *landingDate; // NSDate from NSString
@property (nonatomic, readonly) NSDate *launchDate; // NSDate from NSString
@property (nonatomic, readonly, copy) NSString *status;
@property (nonatomic, readonly) int maxSol;
@property (nonatomic, readonly) NSDate *maxDate; // NSDate from NSString
@property (nonatomic, readonly) int totalPhotos;
@property (nonatomic, readonly, copy) NSArray<Camera *> *cameras;

@end

NS_ASSUME_NONNULL_END
