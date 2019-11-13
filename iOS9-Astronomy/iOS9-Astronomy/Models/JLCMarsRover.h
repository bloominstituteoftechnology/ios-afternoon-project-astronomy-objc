//
//  JLCMarsRover.h
//  iOS9-Astronomy
//
//  Created by Jake Connerly on 11/12/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JLCMarsRover : NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property(nonatomic, readonly) double maxSol;

-(instancetype)initWithName:(NSString *)name
                     maxSol:(double) maxSol;

- (nullable instancetype)initWithDictionary:(NSDictionary *)roverDictionary;

@end

NS_ASSUME_NONNULL_END
