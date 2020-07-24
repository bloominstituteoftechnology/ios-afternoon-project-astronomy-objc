//
//  MarsRoverApiController.m
//  AstronomyOBJC
//
//  Created by Kelson Hartle on 7/23/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import "MarsRoverApiController.h"
#import "AstronomyOBJC-Swift.h"

//apikey 6uIKekXwxAAc5xXCn1jv0667fXDZJGlP813TJOhp
//https://api.nasa.gov/planetary/apod?api_key=6uIKekXwxAAc5xXCn1jv0667fXDZJGlP813TJOhp

/*
 EXTRA https://api.nasa.gov/mars-photos/api/v1/rovers/Curiosity/photos?sol=3&api_key=qzGsj0zsKk6CA9JZP1UjAbpQHabBfaPg2M5dGMB7
 
 BASEURL - https://api.nasa.gov/mars-photos/api/v1
 
-- EXAMPLE QUERY --
This will give us the pictures from the curiosity from sol 1000 from the fhaz camera.
 https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&camera=fhaz&api_key=DEMO_KEY
 
 This will give us all photos from one single day back
 https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=12&api_key=DEMO_KEY
 
 
 This will give you one image back from the server.
 using the image url given from the json given from the url above.
 */

@implementation MarsRoverApiController



/*
 OBJC
 // Fast prototype to make sure it's working (UI Image downloading from server)
 
 // MUST Change url to be secure using file given in url+secure.
 NSURL *photoURL = //Use NSURLComponents to create photo URL from API data (sol # + 1st photo in list)'
 
 NSError *imageError = nil;
 NSData *imageData = [NSData dataWithContentsOfURL:photoURL options: 0 error: &error];
 
 if (imageError) {
    NSLog(@"ImageError", imageError);
    return;
 }
UIImage *image = [UIImage imageWithData: imageData];
 
 TODO: Update the UI on the main thread but can test using synchronous for now.
 imageView.image = image;
 
 */






@end
