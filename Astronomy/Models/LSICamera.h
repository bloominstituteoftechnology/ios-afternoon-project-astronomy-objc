//
//  LSICamera.h
//  Astronomy
//
//  Created by Andrew R Madsen on 11/28/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Camera)
@interface LSICamera : NSObject

- (instancetype)initWithIdentifier:(NSInteger)identifier name:(NSString *)name roverId:(NSInteger)roverId fullName:(NSString *)fullName;

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly) NSInteger identifier;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSInteger roverId;
@property (nonatomic, readonly) NSString *fullName;


@end

NS_ASSUME_NONNULL_END
