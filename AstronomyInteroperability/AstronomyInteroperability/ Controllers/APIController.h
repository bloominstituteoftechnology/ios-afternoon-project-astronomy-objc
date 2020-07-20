//
//  APIController.h
//  AstronomyInteroperability
//
//  Created by Nonye on 7/20/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class Rover;
@interface APIController : NSObject

@property (nonatomic, copy, readonly, nonnull) NSArray<Rover *> *solPhotos;


@end

NS_ASSUME_NONNULL_END
