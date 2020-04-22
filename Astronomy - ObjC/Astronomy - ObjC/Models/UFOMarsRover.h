//
//  UFOMarsRover.h
//  Astronomy - ObjC
//
//  Created by Ufuk Türközü on 21.04.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UFOMarsPhoto;
@class UFOCamera;

@interface UFOMarsRover : NSObject

@property (nonatomic, readonly, copy)NSString *identifier;
@property (nonatomic, readonly, copy)NSString *name;
@property (nonatomic, readonly, copy)NSDate *landingDate;
@property (nonatomic, readonly, copy)NSDate *launchDate;
@property (nonatomic, readonly, copy)NSString *status;
@property (nonatomic, readonly)int maxSol;
@property (nonatomic, readonly, copy)NSDate *maxDate;
@property (nonatomic, readonly)int totalPhotos;
@property (nonatomic, readonly, copy)NSArray<UFOCamera *> *cameras;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
