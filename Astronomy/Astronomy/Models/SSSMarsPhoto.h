//
//  SSSMarsPhoto.h
//  Astronomy
//
//  Created by Shawn Gee on 5/18/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(MarsPhoto)
@interface SSSMarsPhoto : NSObject

@property (nonatomic, readonly) int solNumber;
@property (nonatomic, readonly, copy) NSString *earthDate;
@property (nonatomic, readonly) NSURL *imageURL;
@property (nonatomic, readonly, copy) NSString *cameraName;
@property (nonatomic, readonly) int roverID;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
