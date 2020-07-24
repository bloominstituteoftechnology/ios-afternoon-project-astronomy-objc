//
//  MarsRoverApiController.h
//  AstronomyOBJC
//
//  Created by Kelson Hartle on 7/23/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//apikey 6uIKekXwxAAc5xXCn1jv0667fXDZJGlP813TJOhp
//https://api.nasa.gov/planetary/apod?api_key=6uIKekXwxAAc5xXCn1jv0667fXDZJGlP813TJOhp

/*
 
-- EXAMPLE QUERY --
This will give us the pictures from the curiosity from sol 1000 from the fhaz camera.
 https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&camera=fhaz&api_key=DEMO_KEY
 
 */

@interface MarsRoverApiController : NSObject






@end

NS_ASSUME_NONNULL_END
