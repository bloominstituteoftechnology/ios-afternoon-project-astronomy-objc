//
//  JLRCamera.h
//  Astronomy
//
//  Created by Jesse Ruiz on 12/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(Camera)
@interface JLRCamera : NSObject

//TODO: Make it Codable & Equatable

@property (nonatomic, copy, readonly, nonnull) NSString *name;
@property (nonatomic, readonly) double identification;
@property (nonatomic, readonly) double roverId;
@property (nonatomic, copy, readonly, nonnull) NSString *fullName;

- (nonnull instancetype)initWithName:(nonnull NSString *)name
                      identification:(double)identification
                             roverId:(double)roverId
                            fullName:(nonnull NSString *)fullName;

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)cameraDictionary;

@end
