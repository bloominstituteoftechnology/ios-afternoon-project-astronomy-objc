//
//  REPRoverPhotoReference.m
//  Astronomy Combo
//
//  Created by Michael Redig on 10/14/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

#import "REPRoverPhotoReference.h"

@implementation REPRoverPhotoReference

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
	if (self = [super init]) {

		NSNumber *solNumber = dictionary[@"sol"];
		NSNumber *totalPhotos = dictionary[@"total_photos"];
		NSArray<NSString *> *cameras = dictionary[@"cameras"];

		if (solNumber && totalPhotos && cameras) {
			_totalPhotos = [totalPhotos unsignedIntValue];
			_sol = [solNumber unsignedIntValue];
			_cameras = cameras;
		} else {
			return nil;
		}
	}
	return self;
}

@end
