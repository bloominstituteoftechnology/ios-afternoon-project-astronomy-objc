//
//  SolArrayResult.h
//  AstronomyObjC
//
//  Created by Nick Nguyen on 4/21/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Sol;
NS_ASSUME_NONNULL_BEGIN

@interface SolArrayResult : NSObject

@property (nonatomic, readonly, copy)NSArray<Sol *> *solArray;

- (instancetype)initWithSols:(NSArray<Sol *> *)sols;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
