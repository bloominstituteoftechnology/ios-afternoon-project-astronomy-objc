//
//  CDGCamera.h
//  AstronomyObjC
//
//  Created by Chris Gonzales on 4/21/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDGCamera : NSObject

@property (nonatomic, readonly) NSInteger identifier;
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly) NSInteger roverID;
@property (nonatomic, readonly, copy) NSString *fullName;

- (instancetype)initWithIdentifier:(NSInteger)identifier
                              name:(NSString *)name
                           roverID:(NSInteger)roverID
                          fullName:(NSString *)fullName;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
