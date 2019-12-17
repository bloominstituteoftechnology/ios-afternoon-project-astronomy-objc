//
//  GIPMarsRover.h
//  Astronomy Objc
//
//  Created by Gi Pyo Kim on 12/16/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GIPSol;

NS_SWIFT_NAME(MarsRover)
@interface GIPMarsRover : NSObject

@property (nonatomic, readonly, copy, nonnull) NSString *name;
@property (nonatomic, readonly) int maxSol;
@property (nonatomic, readonly, copy, nonnull) NSArray<GIPSol *> *sols;

- (nonnull instancetype)initWithName:(nonnull NSString *)name maxSol:(int)maxSol sols:(nonnull NSArray<GIPSol *>*)sols;

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionatry;

@end

