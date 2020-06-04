//
//  SolDescription.h
//  Astronomy in OBJC
//
//  Created by Sal B Amer on 6/4/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SolDescription : NSObject

@property NSNumber *sol;
@property NSNumber *totalPhotos;
@property NSMutableArray *cameras;

-(instancetype) initWithSol:(NSNumber *)sol
                totalPhotos:(NSNumber *)totalPhotos
                    cameras:(NSMutableArray *)cameras;

@end

NS_ASSUME_NONNULL_END
