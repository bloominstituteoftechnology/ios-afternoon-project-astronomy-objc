//
//  HAOPhotoResult.m
//  Astronomy-ObjcSwift
//
//  Created by Hunter Oppel on 6/15/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

#import "HAOPhotoResult.h"
#import "HAOPhoto.h"

@implementation HAOPhotoResult

- (instancetype)initWithPhotos:(NSArray<HAOPhoto *> *)photos
{
    self = [super init];
    if (self) {
        _photos = [photos copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSArray *photoDictionaries = dictionary[@"photos"];
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    
    for (NSDictionary *photoDictionary in photoDictionaries) {
        HAOPhoto *photo = [[HAOPhoto alloc] initWithDictionary:photoDictionary];
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
