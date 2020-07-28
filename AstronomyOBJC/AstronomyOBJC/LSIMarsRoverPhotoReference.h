//
//  LSIMarsRoverPhotoReference.h
//  AstronomyOBJc
//
//  Created by Kelson Hartle on 7/25/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSIMarsCamera;

NS_ASSUME_NONNULL_BEGIN

@interface LSIMarsRoverPhotoReference : NSObject

@property (nonatomic) NSNumber *sol;
@property (nonatomic) NSNumber *identifier;
@property (nonatomic) LSIMarsCamera *camera;
@property (nonatomic) NSURL *imageSource;
@property (nonatomic, copy) NSString *earthDate;

-(instancetype)initWithSol:(NSNumber *)sol
                identifier:(NSNumber *)identifier
                    camera:(LSIMarsCamera *)camera
               imageSource:(NSURL *)imageSource
                 earthDate:(NSString *)earthDate;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;









@end

NS_ASSUME_NONNULL_END
