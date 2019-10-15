//
//  MJRPhotoReference.m
//  Astronomy-Objc
//
//  Created by Marlon Raskin on 10/14/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

#import "MJRPhotoReference.h"
#import "Astronomy-Objc-Bridging-Header.h"

@implementation MJRPhotoReference

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {

        _sol = [dictionary[@"sol"] intValue];
        _totalPhotos = [dictionary[@"total_photos"] intValue];
        _cameras = dictionary[@"cameras"];
        _imageURL = dictionary[@"image_src"];
    }
    return self;
}

@end
