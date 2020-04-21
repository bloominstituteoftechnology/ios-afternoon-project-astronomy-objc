//
//  DMOSolDescription.h
//  AstronomyObjC
//
//  Created by morse on 1/26/20.
//  Copyright © 2020 morse. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(SolDescription)
@interface DMOSolDescription : NSObject

@property (nonatomic) int sol;

- (nonnull instancetype)initWithSol:(int)sol;
- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end
