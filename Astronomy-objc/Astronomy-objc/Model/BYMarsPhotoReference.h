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

@property NSNumber *refernceId;
@property NSNumber *sol;
@property BYCamera *camera;
@end

