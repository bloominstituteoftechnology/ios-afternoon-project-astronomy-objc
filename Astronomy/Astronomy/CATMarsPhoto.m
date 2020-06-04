//
//  CATMarsPhoto.m
//  Astronomy
//
//  Created by Jessie Ann Griffin on 6/3/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

#import "CATMarsPhoto.h"

@implementation CATMarsPhoto

- (instancetype)initWithID:(int)anIdentifier
                       sol:(int)aSol
                    camera:(CATCamera *)aCamera
                 earthDate:(NSDate *)earthDate
                  imageURL:(NSURL *)imageURL
{
    if (self = [super init]) {
        _identifier = anIdentifier;
        _sol = aSol;
        _camera = aCamera;
        _earthDate = earthDate;
        _imageURL = imageURL;
    }
    return self;
}

//- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary
//{
//    
//}

@end
