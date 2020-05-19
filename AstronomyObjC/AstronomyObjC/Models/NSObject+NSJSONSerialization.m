//
//  NSObject+NSJSONSerialization.m
//  AstronomyObjC
//
//  Created by Christopher Devito on 5/18/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import "NSObject+NSJSONSerialization.h"
#import "TMCMarsPhotoReference.h"
#import "TMCMarsPhotoReference+NSJSONSerialization.h"

@implementation NSObject (NSJSONSerialization)

- (instancetype)initArrayWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    NSMutableArray *photoArray = [[NSMutableArray alloc] init];
    NSArray *photos = dictionary[@"photos"];
    for (int i = 0; i < photos.count; i++) {
        TMCMarsPhotoReference *photo = [[TMCMarsPhotoReference alloc] initWithMarsPhotoDictionary:photos[i]];
        [photoArray addObject:photo];
    }
    return photoArray;
}


@end
