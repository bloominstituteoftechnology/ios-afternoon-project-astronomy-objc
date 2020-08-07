//
//  CLMPhotoFetcher.m
//  Astronomy
//
//  Created by Claudia Maciel on 8/7/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

#import "CLMPhotoFetcher.h"
#import "CLMPhoto.h"
#import "CLMPhotoResult.h"
#import "LSIErrors.h"
#import "LSILog.h"


////https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY
static NSString *baseURLString = @"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?";
static NSString *APIKey = @"UGalbvgVb4Ncm7dqd6ZQpDAZneeW0232rsZyAlH";

@implementation CLMPhotoFetcher

- (void)fetchPhotosFromSol:(NSNumber *)sol completion:(CLMPhotoFetcherCompletion)completion
{
    
}

@end
