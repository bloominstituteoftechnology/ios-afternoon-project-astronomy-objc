//
//  LSIMarsPhotoReference.h
//  AstronomyOBJC
//
//  Created by Kelson Hartle on 7/24/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSIMarsCamera;

NS_ASSUME_NONNULL_BEGIN

@interface LSIMarsPhotoReference : NSObject

@property NSNumber *sol;
@property NSNumber *identifier;
@property LSIMarsCamera *camera;
@property NSURL *imageSource;
@property NSString *earthDate;

-(instancetype)initWithSol:(NSNumber *)sol
                identifier:(NSNumber *)identifier
                    camera:(LSIMarsCamera *)camera
               imageSource:(NSURL *)imageSource
                 earthDate:(NSString *)earthDate;


@end

NS_ASSUME_NONNULL_END
