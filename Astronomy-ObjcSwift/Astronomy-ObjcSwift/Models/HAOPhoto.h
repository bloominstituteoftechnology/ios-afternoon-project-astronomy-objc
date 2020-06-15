//
//  Photo.h
//  Astronomy-ObjcSwift
//
//  Created by Hunter Oppel on 6/15/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Rover;

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(Photo)

@interface HAOPhoto : NSObject

@property (nonatomic) NSNumber *photoId;
@property (nonatomic) NSNumber *sol;
@property (nonatomic) NSURL *imgURL;
@property (nonatomic) NSDate *earthDate;
@property (nonatomic) Rover *rover;

- (instancetype)initWithPhotoId:(NSNumber *)photoId sol:(NSNumber *)sol imgURL:(NSURL *)imgURL earthDate:(NSDate *)earthDate rover:(Rover *)rover;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
