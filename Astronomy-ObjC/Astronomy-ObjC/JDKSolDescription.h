//
//  JDKSolDescription.h
//  Astronomy-ObjC
//
//  Created by John Kouris on 2/12/20.
//  Copyright © 2020 John Kouris. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(SolDescription)
@interface JDKSolDescription : NSObject

@property (nonatomic, readonly) int sol;
@property (nonatomic, readonly) int totalPhotos;

- (nonnull instancetype)initWithSol:(int)sol totalPhotos:(int)totalPhotos;
- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
