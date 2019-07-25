//
//  HSVSolPhotDescription.m
//  astronomy-objc
//
//  Created by Hector Steven on 7/24/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

#import "HSVSolPhotDescription.h"

@implementation HSVSolPhotDescription



- (instancetype)initWithSol:(NSString *)sol img_src:(NSString *)img_src earthDate:(NSString *)earthDate cameraName:(NSString *)cameraName roverName:(NSString *)roverName
{
	self = [super init];
	if (self) {
		_sol = sol;
		_img_src = img_src;
		_earthDate = earthDate;
		_cameraName = cameraName;
		_rovername = roverName;
	}
	return self;
}

- (instancetype) initWithDictionary:(NSDictionary *)dictionary{
	
	NSLog(@"%@", dictionary);
	_sol = @"";
	_img_src = @"";
	_earthDate = @"";
	_earthDate = @"";
	_cameraName = @"";
	_rovername = @"";
	
	return  self;
}


@end
