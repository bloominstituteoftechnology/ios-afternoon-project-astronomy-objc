//
//  LSICamera.m
//  Astronomy
//
//  Created by David Wright on 6/3/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

#import "LSICamera.h"

@implementation LSICamera

- (instancetype)initWithCameraId:(int)cameraId roverId:(int)roverId name:(NSString *)name fullName:(NSString *)fullName
{
    if (self = [super init]) {
        _cameraId = cameraId;
        _roverId = roverId;
        _name = name.copy;
        _fullName = fullName.copy;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSNumber *cameraId = [dictionary objectForKey:@"id"];
    if (![cameraId isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *roverId = [dictionary objectForKey:@"rover_id"];
    if (![roverId isKindOfClass:[NSNumber class]]) return nil;
    
    NSString *name = [dictionary objectForKey:@"name"];
    if (![name isKindOfClass:[NSString class]]) return nil;
    
    NSString *fullName = [dictionary objectForKey:@"full_name"];
    if (![name isKindOfClass:[NSString class]]) return nil;
    
    return [self initWithCameraId:cameraId.intValue
                          roverId:roverId.intValue
                             name:name
                         fullName:fullName];
}

@end
