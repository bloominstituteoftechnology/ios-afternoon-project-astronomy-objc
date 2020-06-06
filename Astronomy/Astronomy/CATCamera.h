//
//  CATCamera.h
//  Astronomy
//
//  Created by Jessie Ann Griffin on 6/3/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Camera)
@interface CATCamera : NSObject

@property (nonatomic, readonly) int identifier;
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly) int roverID;
@property (nonatomic, readonly, copy) NSString *fullName;

- (instancetype)initWithID:(int)anIdentifier
                      name:(NSString *)aName
                   roverID:(int)roverID
                  fullName:(NSString *)aFullName;

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
