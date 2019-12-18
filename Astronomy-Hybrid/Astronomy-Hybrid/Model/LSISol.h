//
//  LSISol.h
//  Astronomy-Hybrid
//
//  Created by Isaac Lyons on 12/16/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(Sol)
@interface LSISol : NSObject

@property (nonatomic, readonly) int sol;
@property (nonatomic, readonly) int totalPhotos;

- (nonnull instancetype)initWithSol:(int)sol
                        totalPhotos:(int)totalPhotos;

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end
