//
//  HSVSol.m
//  astronomy-objc
//
//  Created by Hector Steven on 7/22/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

#import "HSVSol.h"

@implementation HSVSol

- (instancetype)initWithSol:(int)sol totalPhotos:(int)totalPhotos earthDate:(NSString *)earthDate cameras:(NSArray *)cameras;
{
	self = [super init];
	if (self) {
		_sol = sol;
		_totalPhotos = totalPhotos;
		_earthDate = earthDate;
		_cameras = cameras;
	}
	return self;
}



@end
