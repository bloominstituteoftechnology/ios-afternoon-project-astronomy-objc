//
//  LSIMarsPhotoReference.h
//  Astronomy
//
//  Created by Andrew R Madsen on 10/8/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSICamera;

NS_ASSUME_NONNULL_BEGIN

@interface LSIMarsPhoto : NSObject

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly) NSInteger identifier;
@property (nonatomic, readonly) NSInteger sol;
@property (nonatomic, strong, readonly) LSICamera *camera;
@property (nonatomic, strong, readonly) NSDate *earthDate;

@property (nonatomic, strong, readonly) NSURL *imageURL;

@end

NS_ASSUME_NONNULL_END
