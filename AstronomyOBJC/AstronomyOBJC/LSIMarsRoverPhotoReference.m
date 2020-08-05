//
//  LSIMarsRoverPhotoReference.m
//  AstronomyOBJc
//
//  Created by Kelson Hartle on 7/25/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import "LSIMarsRoverPhotoReference.h"
#import "LSIMarsCamera.h"



@implementation LSIMarsRoverPhotoReference

-(instancetype)initWithSol:(NSNumber *)sol
                identifier:(NSNumber *)identifier
                    camera:(LSIMarsCamera *)camera
               imageSource:(NSURL *)imageSource
                 earthDate:(NSString *)earthDate {
    
    self = [super init];
    if (self) {
        _sol = sol;
        _identifier = identifier;
        _camera = camera;
        _imageSource = imageSource;
        _earthDate = [earthDate copy];
    }
    return self;
}



-(instancetype)initWithDictionary:(NSDictionary *)dictionary; {
    
    NSNumber *sol = dictionary[@"sol"];
    NSNumber *identifier = dictionary[@"id"];
    NSDictionary *cameraDictionary = dictionary[@"camera"];
    LSIMarsCamera *camera = [[LSIMarsCamera alloc] initWithDictionary:cameraDictionary];
    
    NSURL *imageSource = [NSURL URLWithString:dictionary[@"img_src"]];
    NSString *earthDate = dictionary[@"earth_date"];
    
    self = [self initWithSol:sol identifier:identifier camera:camera imageSource:imageSource earthDate:earthDate];
    
    
    return self;
}

@end
