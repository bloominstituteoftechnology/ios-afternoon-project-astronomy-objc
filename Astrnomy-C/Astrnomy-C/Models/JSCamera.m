//
//  JSCamera.m
//  Astrnomy-C
//
//  Created by Jeffrey Santana on 10/14/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

#import "JSCamera.h"

@implementation JSCamera

- (instancetype)initWithDictionary:(NSDictionary *)cameraDict {
	self = [super init];
	if (self) {
		_id = [cameraDict[@"id"] intValue];
		_name = cameraDict[@"name"];
		_roverId = [cameraDict[@"rover_id"] intValue];
		_fullName = cameraDict[@"full_name"];
	}
	return self;
}

@end
