//
//  CMDCamera.h
//  Astronomy
//
//  Created by Chris Dobek on 6/17/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMDCamera : NSObject

@property (nonatomic, readonly) int identifier;
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly) int roverID;
@property (nonatomic, readonly, copy) NSString *fullName;

- (instancetype)initWithIdentifier:(int)identifier
                              name:(NSString *)name
                           roverID:(int)roverID
                          fullName:(NSString *)fullName;

@end

NS_ASSUME_NONNULL_END
