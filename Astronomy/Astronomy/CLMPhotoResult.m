//
//  CLMPhotoResult.m
//  Astronomy
//
//  Created by Claudia Maciel on 8/6/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

#import "CLMPhotoResult.h"
#import "CLMPhoto.h"

@implementation CLMPhotoResult

-(instancetype)initWithPhotos:(NSArray<CLMPhoto *> *)photos
{
    self = [super init];
    
    if(self)
    {
        _photos = [photos copy];
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    return nil;
}

@end
