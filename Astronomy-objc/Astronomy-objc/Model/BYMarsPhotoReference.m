//
//  BYMarsPhotoReference.m
//  Astronomy-objc
//
//  Created by Bradley Yin on 10/14/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

#import "BYMarsPhotoReference.h"
#import "Astronomy_objc-Swift.h"

@implementation BYMarsPhotoReference

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        _refernceId = dictionary[@"id"];
        _sol = dictionary[@"sol"];
        NSDictionary *cameraDictionary = dictionary[@"camera"];
        
        NSNumber *cameraId = cameraDictionary[@"id"];
        NSString *name = cameraDictionary[@"name"];
        NSNumber *cameraRoverId = cameraDictionary[@"rover_id"];
        NSString *cameraFullName = cameraDictionary[@"full_name"];
        
        _camera = [[Camera alloc] initWithId:[cameraId intValue] name:name roverId:[cameraRoverId intValue] fullName:cameraFullName];
        
        _earthDate = dictionary[@"earth_date"];
        _imageURL = [NSURL URLWithString:dictionary[@"img_src"]] ;
    }
    return self;
}

@end
