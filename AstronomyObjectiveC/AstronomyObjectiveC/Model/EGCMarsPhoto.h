//
//  EGCMarsPhoto.h
//  AstronomyObjectiveC
//
//  Created by Enrique Gongora on 4/21/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EGCCamera;

NS_ASSUME_NONNULL_BEGIN

@interface EGCMarsPhoto : NSObject

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly) NSInteger identifier;
@property (nonatomic, readonly) NSInteger sol;
@property (nonatomic, strong, readonly) EGCCamera *camera;
@property (nonatomic, strong, readonly) NSDate *earthDate;

@property (nonatomic, strong, readonly) NSURL *imageURL;

@end

NS_ASSUME_NONNULL_END
