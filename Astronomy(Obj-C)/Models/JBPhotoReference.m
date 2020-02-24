//
//  JBPhotoReference.m
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-27.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import "JBPhotoReference.h"

@implementation JBPhotoReference

- (instancetype)initWithURL:(NSURL *)imageURL
                    photoID:(NSUInteger)photoID
                 cameraName:(NSString *)cameraName
{
    self = [super init];
    if (self) {
        _imageURL = imageURL;
        _photoID = photoID;
        _cameraName = cameraName;
    }
    return self;
}

- (instancetype)initFromDictionary:(NSDictionary *)dictionary {
    NSNumber *photoIDObject = dictionary[@"id"];
    NSString *imageURLString = dictionary[@"img_src"];
    NSDictionary *cameraDict = dictionary[@"camera"];
    NSString *cameraName = cameraDict[@"full_name"];

    self = [[JBPhotoReference alloc]
            initWithURL:[NSURL URLWithString:imageURLString]
            photoID:photoIDObject.unsignedIntegerValue
            cameraName:cameraName];
    return self;
}


@end
