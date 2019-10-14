//
//  REPRoverInfo.h
//  Astronomy Combo
//
//  Created by Michael Redig on 10/14/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
@class REPRoverPhotoReference;

NS_SWIFT_NAME(RoverInfo)
@interface REPRoverInfo : NSObject

@property (nonatomic, readonly, nonnull) NSString *name;
@property (nonatomic, readonly, nonnull) NSArray<REPRoverPhotoReference *> *photosReferences;


@end
