//
//  RoverPhoto.m
//  Astronomy-ObSwiftive-c
//
//  Created by Craig Swanson on 4/20/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import "RoverPhoto.h"

@implementation RoverPhoto

-(instancetype)initWithPhotoID:(uint)photoID sol:(int)sol photoURL:(NSURL *)photoURL {
    if (self = [self init]) {
        _photoID = photoID;
        _sol = sol;
        _photoURL = photoURL;
    }
    return self;
}

@end
