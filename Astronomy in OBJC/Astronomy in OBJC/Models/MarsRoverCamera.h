//
//  MarsRoverCamera.h
//  Astronomy-in-OBJC
//
//  Created by Sal B Amer on 6/4/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MarsRoverCamera : NSObject

@property NSNumber *identity;
@property NSString *name;
@property NSNumber *roverId;
@property NSString *fullName;

-(instancetype)initWithIdentity:(NSNumber *) identity
                           name:(NSString *) name
                        roverId:(NSNumber *) roverId
                       fullName:(NSString *) fullName;

@end

NS_ASSUME_NONNULL_END
