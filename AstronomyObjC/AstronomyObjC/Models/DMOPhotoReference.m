//
//  DMOPhotoReference.m
//  AstronomyObjC
//
//  Created by morse on 1/26/20.
//  Copyright © 2020 morse. All rights reserved.
//

#import "DMOPhotoReference.h"

@implementation DMOPhotoReference

- (instancetype)initWithID:(int)id imageURL:(NSURL *)imageURL {
    self = [super init];
    if (self) {
        _id = id;
        _imageURL = imageURL;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    int id = [dictionary[@"id"] intValue];
    NSURL *imageURL = dictionary[@"img_src"];
    
    return [self initWithID:id imageURL:imageURL];
}

@end
