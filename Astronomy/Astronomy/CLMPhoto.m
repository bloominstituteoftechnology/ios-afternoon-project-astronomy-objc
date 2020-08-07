//
//  CLMPhoto.m
//  Astronomy
//
//  Created by Claudia Maciel on 8/6/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

#import "CLMPhoto.h"

@implementation CLMPhoto

- (instancetype) initWithPhotoId:(NSNumber *)photoId sol:(NSNumber *)sol imgURL:(NSURL *)imgURL earthDate:(NSDate *)earthDate rover:(Rover *)rover
{
    self = [super init];
    
    if(self)
    {
        _photoId = photoId;
        _sol = sol;
        _imgURL = imgURL;
        _earthDate = earthDate;
        _rover = rover;
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    return nil;
}

@end
