//
//  MBCamera.h
//  ObjCAstronomy
//
//  Created by Mitchell Budge on 7/23/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBCamera : NSObject

@property NSInteger identifier;
@property NSString *name;
@property NSInteger roverID;
@property NSString *fullName;

@end

NS_ASSUME_NONNULL_END
