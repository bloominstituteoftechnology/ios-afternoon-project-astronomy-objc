//
//  JDKSolDescription.h
//  Astronomy-ObjC
//
//  Created by John Kouris on 2/12/20.
//  Copyright © 2020 John Kouris. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDKSolDescription : NSObject

@property (nonatomic, readonly) int sol;
@property (nonatomic, readonly) int totalPhotos;
@property (nonatomic, copy, readonly, nonnull) NSArray<NSString *> *cameras;

@end

NS_ASSUME_NONNULL_END
