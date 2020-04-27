//
//  Rover.m
//  Astronomy-objc
//
//  Created by Dillon P on 4/26/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

#import "Rover.h"

@implementation Rover

- (instancetype)initWithIdentifier:(int)identifier
                              name:(NSString *)name
                       landingDate:(NSString *)landingDate
                        launchDate:(NSString *)launchDate
                            status:(NSString *)status
                            maxSol:(int)maxSol
                           maxDate:(NSString *)maxDate
                       totalPhotos:(int)totalPhotos
                            photos:(Photo *)photos
{
    if (self = [super init]) {
        _identifier = identifier;
        _name = name;
        _landingDate = landingDate;
        _launchDate = launchDate;
        _status = status;
        _maxSol = maxSol;
        _maxDate = maxDate;
        _totalPhotos = totalPhotos;
        _photos = photos;
    }
    
    return self;
}

@end
