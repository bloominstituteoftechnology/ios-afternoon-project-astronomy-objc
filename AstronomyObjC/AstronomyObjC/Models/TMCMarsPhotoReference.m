//
//  TMCMarsPhotoReference.m
//  AstronomyObjC
//
//  Created by Christopher Devito on 5/18/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import "TMCMarsPhotoReference.h"

@implementation TMCMarsPhotoReference
-(instancetype) initWithIdentification:(NSNumber *)identification
                                   sol:(NSNumber *)sol
                                camera:(NSString *)camera
                             earthDate:(NSDate *)earthDate
                              imageURL:(NSURL *)imageURL {
    self = [super init];
    if (self) {
        _identification = identification;
        _sol = sol;
        _camera = camera;
        _earthDate = earthDate;
        _imageURL = imageURL;
    }
    return self;
}

@end
