//
//  DMORover.h
//  AstronomyObjC
//
//  Created by morse on 1/26/20.
//  Copyright © 2020 morse. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DMOSolDescription;

NS_SWIFT_NAME(Rover)
@interface DMORover : NSObject

@property (nonatomic, copy, nonnull) NSString *name;
@property (nonatomic, copy, nonnull) NSArray<DMOSolDescription *> *solDescriptions;

- (nonnull instancetype)initWithName:(nonnull NSString *)name solDescriptions:(nonnull NSArray<DMOSolDescription *> *)sols;
- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end
