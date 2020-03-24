//
//  MBMPhotoResults.m
//  Astronomy-Objc
//
//  Created by Michael on 3/23/20.
//  Copyright © 2020 Michael. All rights reserved.
//

#import "MBMPhotoResults.h"
#import "MBMPhoto.h"

@implementation MBMPhotoResults

- (instancetype)initWithPhotos:(NSArray<MBMPhoto *> *)photos {
    self = [super init];
    if (self) {
        _photos = [photos copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    NSArray *photoDictionaries = dictionary[@"photos"];
    
    NSMutableArray<MBMPhoto *> *photos = [[NSMutableArray alloc] init];
    
    for (NSDictionary *photoDict in photoDictionaries) {
        MBMPhoto *photo = [[MBMPhoto alloc] initWithDictionary:photoDict];
        
        if (photo) {
            [photos addObject:photo];
        } else {
            NSLog(@"Unable to parse photo dictionary: %@", photoDict);
        }
    }
    self = [self initWithPhotos:photos];
    return self;
}


@end
