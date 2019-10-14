//
//  REPRoverPhotoReference.h
//  Astronomy Combo
//
//  Created by Michael Redig on 10/14/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface REPRoverPhotoReference : NSObject


@property (nonatomic, readonly) NSUInteger totalPhotos;
@property (nonatomic, readonly) NSUInteger sol;
@property (nonatomic, readonly, nonnull) NSArray<NSString *> *cameras;

@end

