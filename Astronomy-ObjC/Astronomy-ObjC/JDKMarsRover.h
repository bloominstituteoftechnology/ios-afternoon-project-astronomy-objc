//
//  JDKMarsRover.h
//  Astronomy-ObjC
//
//  Created by John Kouris on 2/12/20.
//  Copyright © 2020 John Kouris. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JDKSolDescription;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(MarsRover)
@interface JDKMarsRover : NSObject

@property (nonatomic, readonly, copy, nonnull) NSString *name;
@property (nonatomic, readonly, copy, nonnull) NSArray<JDKSolDescription *> *sols;

- (nonnull instancetype)initWithName:(nonnull NSString *)name
                                sols:(nonnull NSArray<JDKSolDescription *> *)sols;

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
