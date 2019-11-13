//
//  JLCMarsPhoto.h
//  iOS9-Astronomy
//
//  Created by Jake Connerly on 11/12/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JLCCamera.h"

NS_ASSUME_NONNULL_BEGIN

@interface JLCMarsPhoto : NSObject

@property (nonatomic, readonly) double identifier;
@property (nonatomic, readonly) double sol;
@property (nonatomic, readonly) JLCCamera *camera;
@property (nonatomic, copy, readonly) NSString *earthDate;
@property (nonatomic, copy, readonly) NSURL *imageURL;

- (instancetype)initWithID:(double)identifier
                       sol:(double)sol
                    camera:(JLCCamera *)camera
                 earthDate:(NSString *)earthDate
                  imageURL:(NSURL *)imageURL;

- (nullable instancetype)initWithDictionary:(NSDictionary *)photoDictionary;
@end

NS_ASSUME_NONNULL_END
