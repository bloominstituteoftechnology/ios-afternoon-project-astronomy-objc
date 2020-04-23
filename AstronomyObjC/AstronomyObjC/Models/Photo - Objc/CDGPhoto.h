//
//  CDGPhoto.h
//  AstronomyObjC
//
//  Created by Chris Gonzales on 4/21/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CDGCamera;

NS_ASSUME_NONNULL_BEGIN

@interface CDGPhoto : NSObject

@property (nonatomic, strong, readonly) NSURL *imageURL;
@property (nonatomic, readonly) NSInteger identifier;
@property (nonatomic, readonly) NSInteger sol;
@property (nonatomic, strong, readonly) CDGCamera *camera;
@property (nonatomic, strong, readonly) NSDate *earthDate;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
