//
//  HSVSolImageListController.m
//  astronomy-objc
//
//  Created by Hector Steven on 7/23/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

#import "HSVSolImageListController.h"
//#import "../Mode"

@implementation HSVSolImageListController

static NSString *baseSolImagesUrl = @"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=22&api_key=3Gj8mRPLnRIWJUHtRHrcuy5ZL57sOwNaLX35rBCG";

- (void)fetchImageListWithSol:(int)sol Completion:(void (^)(NSError *error ))completion{
	NSURL *url = [[NSURL alloc] initWithString:baseSolImagesUrl];
	
	NSLog(@"url: %@", url);
	
	[[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
		if (error){
			completion(error);
			return;
		}
		
		NSError *jsonError ;
		
		NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
		
		if (jsonError){
			NSLog(@"error with NSJSONSerialization: %@", jsonError);
			completion(jsonError);
			return;
		}
		
		NSArray *photosArr = jsonDictionary[@"photos"];
		
		for(NSDictionary *dic in photosArr) {
			
			
			NSString *imgSrc = dic[@"img_src"];
			
				//HSVSolPhoto *solPhot = [HSVSolPhoto alloc] initWithImg_src:<#(NSString * _Nonnull)#> sol:<#(NSString * _Nonnull)#> earthDate:<#(NSString * _Nonnull)#> cameraName:<#(NSString * _Nonnull)#> roverName:<#(NSString * _Nonnull)#>
			NSLog(@"%@", imgSrc);
		}
		
		NSLog(@"%li", [photosArr count]);
		
			//		NSArray *solImageArr = jsonDictionary[@"photo_manifest"][0][@"photos"];
			//
			//		[self getInternalSolsWitArr:solArr];
			//
			//
			//		completion( , nil);
	}] resume];
}


- (void)Test{
	NSLog(@"Test this");
}

@end
