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

-(instancetype)initWithName:(NSString *)name;

- (nullable instancetype)initWithDictionary:(NSDictionary *)roverDictionary;

@end

NS_ASSUME_NONNULL_END
