//
//  JSCamera.h
//  Astrnomy-C
//
//  Created by Jeffrey Santana on 10/14/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(Camera)
@interface JSCamera : NSObject

@property int id;
@property NSString *name;
@property int roverId;
@property NSString *fullName;

- (instancetype)initWithDictionary:(NSDictionary *)cameraDict;

@end
