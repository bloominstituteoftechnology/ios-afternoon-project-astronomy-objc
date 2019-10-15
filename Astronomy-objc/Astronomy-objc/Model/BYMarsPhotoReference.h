//
//  BYMarsPhotoReference.h
//  Astronomy-objc
//
//  Created by Bradley Yin on 10/14/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Astronomy_objc-Swift.h"


@interface BYMarsPhotoReference : NSObject

@property (nonnull) NSNumber *refernceId;
@property (nonnull) NSNumber *sol;
@property (nonnull) BYCamera *camera;
@property (nonnull) NSDate *earthDate;
@property (nonnull) NSURL *imageURL;

- (instancetype)initWithDictionary:(NSDictionary *_Nonnull)dictionary;
@end

