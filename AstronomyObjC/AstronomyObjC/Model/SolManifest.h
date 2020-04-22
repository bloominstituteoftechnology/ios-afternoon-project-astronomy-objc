//
//  SolManifest.h
//  AstronomyObjC
//
//  Created by Nick Nguyen on 4/22/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SolManifest : NSObject

@property (nonatomic, readonly, nonnull)NSArray *sols;

- (instancetype _Nonnull)initWithDictionary:(NSDictionary *_Nonnull)dictionary;

@end

NS_ASSUME_NONNULL_END
