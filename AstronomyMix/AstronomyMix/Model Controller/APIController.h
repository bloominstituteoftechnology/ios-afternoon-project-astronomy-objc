//
//  APIController.h
//  AstronomyMix
//
//  Created by Jorge Alvarez on 3/23/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Rover;

@interface APIController : NSObject

@property (nonatomic, readonly, copy, nonnull) NSArray<Rover *> *solPhotos;

@end
