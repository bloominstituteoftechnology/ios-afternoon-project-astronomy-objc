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
    NSArray *photoDictionaries = dictionary[@"photos"];
    NSMutableArray *photos = [[NSMutableArray alloc] init];

    for (NSDictionary *photoDictionary in photoDictionaries) {
        CLMPhoto *photo = [[CLMPhoto alloc] initWithDictionary:photoDictionary];
        if (photo) {
            [photos addObject:photo];
        } else {
            NSLog(@"Unable to parse photo dictionary: %@", photoDictionary);
        }
    }

    self = [self initWithPhotos:photos];
    return self;
}

@end
