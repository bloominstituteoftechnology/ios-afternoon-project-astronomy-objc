//
//  LYDCamera.h
//  LYDAstronomyObjC
//
//  Created by Lydia Zhang on 5/18/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(Camera)

@interface LYDCamera : NSObject

@property int identifier;
@property NSString *name;
@property int roverID;
@property NSString *fullName;

- (instancetype)initWithDictionary: (NSDictionary *)cameraDictionary;

@end

