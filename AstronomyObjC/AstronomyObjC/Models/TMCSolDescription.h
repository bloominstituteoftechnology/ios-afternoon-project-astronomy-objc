//
//  TMCSolDescription.h
//  AstronomyObjC
//
//  Created by Christopher Devito on 5/18/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMCSolDescription : NSObject
 
@property NSNumber *sol;
@property NSNumber *totalPhotos;
@property NSMutableArray *cameras;

-(instancetype) initWithSol:(NSNumber *)sol
                totalPhotos:(NSNumber *) totalPhotos
                    cameras:(NSMutableArray *) cameras;

@end

NS_ASSUME_NONNULL_END
