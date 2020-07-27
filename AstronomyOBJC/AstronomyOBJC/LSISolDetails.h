//
//  LSISol.h
//  AstronomyOBJc
//
//  Created by Kelson Hartle on 7/25/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSISolDetails : NSObject

@property (nonatomic) NSNumber *solNumber;
@property (nonatomic) NSNumber *totalPhotos;
@property (nonatomic, copy) NSArray<NSString *> *cameras;

-(instancetype)initWithSolNumber:(NSNumber *)solNumber
                     totalPhotos:(NSNumber *)totalPhotos
                         cameras:(NSArray<NSString *>*)cameras;

@end

NS_ASSUME_NONNULL_END
