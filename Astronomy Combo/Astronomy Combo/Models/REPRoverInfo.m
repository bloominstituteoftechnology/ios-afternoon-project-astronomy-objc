//
//  REPRoverInfo.m
//  Astronomy Combo
//
//  Created by Michael Redig on 10/14/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

#import "REPRoverInfo.h"
#import "REPRoverPhotoReference.h"

@implementation REPRoverInfo

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
	if (self = [super init]) {
		NSDictionary *manifest = dictionary[@"photo_manifest"];
		NSString *name = manifest[@"name"];
		NSArray *rawReferenceArray = manifest[@"photos"];

		if (name && rawReferenceArray) {
			_name = name;
			NSMutableArray<REPRoverPhotoReference *> *referenceArray = [NSMutableArray array];
			for (NSDictionary *dict in rawReferenceArray) {
				REPRoverPhotoReference *ref = [[REPRoverPhotoReference alloc] initWithDictionary:dict];
				if (ref) {
					[referenceArray addObject:ref];
				}
			}
			_photosReferences = [referenceArray copy];
		} else {
			return nil;
		}

	}
	return self;
}
@end
