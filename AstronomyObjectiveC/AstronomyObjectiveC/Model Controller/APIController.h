//
//  APIController.h
//  AstronomyObjectiveC
//
//  Created by Enrique Gongora on 4/20/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Rover;

@interface APIController : NSObject

@property (nonatomic, readonly, copy, nonnull) NSArray<Rover *> *solPhotos;

@end
