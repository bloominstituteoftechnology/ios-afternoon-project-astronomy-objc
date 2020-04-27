//
//  Camera.h
//  Astronomy-objc
//
//  Created by Dillon P on 4/26/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Camera : NSObject

@property (nonatomic, readonly) int identifier; // named "id" in api
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly) int roverID; // named "rover_id" in api
@property (nonatomic, readonly, copy) NSString *fullName;

- (instancetype)initWithIdentifier:(int)identifier
                              name:(NSString *)name
                           roverID:(int)roverID
                          fullName:(NSString *)fullName;

@end

NS_ASSUME_NONNULL_END
