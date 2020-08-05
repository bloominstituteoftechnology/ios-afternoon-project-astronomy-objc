//
//  LSICamera.h
//  AstronomyOBJc
//
//  Created by Kelson Hartle on 7/25/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIMarsCamera : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSNumber *identifier;
@property (nonatomic) NSNumber *roverID;

-(instancetype)initWithName:(NSString *)name
                 identifier:(NSNumber *)identifier
                    roverID:(NSNumber *)roverID;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
