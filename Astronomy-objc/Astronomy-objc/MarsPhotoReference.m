//
//  MarsPhotoReference.m
//  Astronomy-objc
//
//  Created by Matthew Martindale on 8/5/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

#import "MarsPhotoReference.h"

@implementation MarsPhotoReference

- (instancetype)initWithId:(int)photoId
            imageURLString:(NSString *)imageURLString
{
    if (self = [super init]) {
        _photoId = photoId;
        _imageURLString = imageURLString;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSNumber *photoId = [dictionary objectForKey:@"id"];
    if (![photoId isKindOfClass:NSNumber.class]) return nil;
    
    NSString *imageURLString = [dictionary objectForKey:@"img_src"];
    if (![imageURLString isKindOfClass:NSString.class]) return nil;
    
    return [self initWithId:photoId.intValue imageURLString:imageURLString];
}

@end
