//
//  CAMCamera.m
//  Astronomy
//
//  Created by Cody Morley on 7/20/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

#import "CAMCamera.h"

@implementation CAMCamera

- (instancetype)initWithCameraID:(int)cameraId
                         roverId:(int)roverId
                            name:(NSString *)name
                        fullName:(NSString *)fullName
{
    self = [super init];
    if (self) {
        _cameraId = cameraId;
        _roverId = roverId;
        _name = [name copy];
        _fullName = [fullName copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSNumber *cameraId = dictionary[@"id"];
    NSNumber *roverId = dictionary[@"roverId"];
    NSString *name = dictionary[@"fullName"];
    NSString *fullName = dictionary[@"fullName"];
    
    return [self initWithCameraID: cameraId.intValue
                          roverId: roverId.intValue
                             name: name
                         fullName: fullName];
}


@end
