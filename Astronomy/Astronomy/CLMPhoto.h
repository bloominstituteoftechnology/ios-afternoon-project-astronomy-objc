//
//  CLMPhoto.h
//  Astronomy
//
//  Created by Claudia Maciel on 8/6/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Rover;

@interface CLMPhoto : NSObject

@property (nonatomic) NSNumber *photoId;
@property (nonatomic) NSNumber *sol;
@property (nonatomic) NSURL *imgURL;
@property (nonatomic) NSDate *earthDate;
@property (nonatomic) Rover *rover;

- (instancetype)initWithPhotoId:(NSNumber *)photoId sol:(NSNumber *)sol imgURL:(NSURL *)imgURL earthDate:(NSDate *)earthDate rover:(Rover *)rover;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
