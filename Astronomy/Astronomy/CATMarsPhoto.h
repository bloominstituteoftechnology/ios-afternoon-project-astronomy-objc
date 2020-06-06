//
//  CATMarsPhoto.h
//  Astronomy
//
//  Created by Jessie Ann Griffin on 6/3/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CATCamera.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(MarsPhoto)
@interface CATMarsPhoto : NSObject

@property (nonatomic, readonly) int identifier;
@property (nonatomic, readonly) int sol;
@property (nonatomic) CATCamera *camera;
@property (nonatomic, readonly) NSDate *earthDate;
@property (nonatomic, readonly) NSURL *imageURL;

- (instancetype)initWithID:(int)anIdentifier
                       sol:(int)aSol
                    camera:(CATCamera *)aCamera
                 earthDate:(NSDate *)earthDate
                  imageURL:(NSURL *)imageURL;

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
