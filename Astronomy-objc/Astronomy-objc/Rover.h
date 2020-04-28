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
@property (nonatomic, readonly) NSString *landingDate; // NSDate from NSString
@property (nonatomic, readonly) NSString *launchDate; // NSDate from NSString
@property (nonatomic, readonly, copy) NSString *status;
@property (nonatomic, readonly) int maxSol;
@property (nonatomic, readonly) NSString *maxDate; // NSDate from NSString
@property (nonatomic, readonly) int totalPhotos;
@property (nonatomic, readonly, nullable) NSArray *sols;
//@property (nonatomic, readonly, copy) NSArray<Camera *> *cameras;

- (instancetype)initWithIdentifier:(int)identifier
                              name:(nonnull NSString *)name
                       landingDate:(nonnull NSString *)landingDate
                        launchDate:(nonnull NSString *)launchDate
                            status:(nonnull NSString *)status
                            maxSol:(int)maxSol
                           maxDate:(nonnull NSString *)maxDate
                       totalPhotos:(int)totalPhotos
                            sols:(nullable NSArray *)sols;
//                           cameras:(nonnull NSArray<Camera *> *)cameras;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
