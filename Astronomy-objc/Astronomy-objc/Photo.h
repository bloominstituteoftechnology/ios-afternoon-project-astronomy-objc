//
//  Photo.h
//  Astronomy-objc
//
//  Created by Dillon P on 4/27/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Photo : NSObject

@property (nonatomic) int sol;

-(instancetype)initWithSol:(int)sol;

@end

NS_ASSUME_NONNULL_END
