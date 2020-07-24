//
//  LSIMarsCamera.h
//  AstronomyOBJC
//
//  Created by Kelson Hartle on 7/24/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIMarsCamera : NSObject

@property NSString *name;
@property NSNumber *identifier;
@property NSNumber *roverID;

-(instancetype)initWithName:(NSString *)name
                 identifier:(NSNumber *)identifier
                    roverID:(NSNumber *)roverID;

@end

NS_ASSUME_NONNULL_END
