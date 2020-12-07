//
//  CMBMarsObject.m
//  Astronomy
//
//  Created by Craig Belinfante on 12/6/20.
//

#import "CMBMarsObject.h"

@implementation CMBMarsObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
     self = [super init];
     if (!self) { return nil; }

     NSNumber *solNumber = dictionary[@"sol"];
     NSString *imageURLString = dictionary[@"img_src"];
    
     NSDictionary *cameraContainer = dictionary[@"camera"];
     NSNumber *roverID = cameraContainer[@"rover_id"];

     _solNumber = solNumber.intValue;
     _imageURL = [NSURL URLWithString:imageURLString];
     _roverID = roverID.intValue;

     return self;
 }

@end
