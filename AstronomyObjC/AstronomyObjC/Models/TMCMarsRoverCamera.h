//
//  TMCMarsRoverCamera.h
//  AstronomyObjC
//
//  Created by Christopher Devito on 5/18/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMCMarsRoverCamera : NSObject
@property NSNumber *identity;
@property NSString *name;
@property NSNumber *roverId;
@property NSString *fullName;

-(instancetype)initWithIdentity:(NSNumber *) identity
                           name:(NSString *) name
                        roverID:(NSNumber *) roverID
                       fullName:(NSString *) fullName;
@end

NS_ASSUME_NONNULL_END
