//
//  HSVSolController.m
//  astronomy-objc
//
//  Created by Hector Steven on 7/22/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

#import "HSVSolController.h"

@implementation HSVSolController

- (instancetype)init
{
	self = [super init];
	if (self) {
		
	}
	return self;
}

static NSString *baseSolUrl = @"https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity?api_key=3Gj8mRPLnRIWJUHtRHrcuy5ZL57sOwNaLX35rBCG";
static NSString *baseSolImagesUrl = @"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=22&api_key=3Gj8mRPLnRIWJUHtRHrcuy5ZL57sOwNaLX35rBCG#";


- (void)fetchSolsWithCompletion:(void (^)(NSError * _Nullable))completion{
	
	NSURL *url = [[NSURL alloc] initWithString:baseSolUrl];
	
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
		
		NSLog(@"%@", jsonDictionary[@"photo_manifest"][@"photos"][0]);
		
		
		completion(nil);
	}] resume];
	
	
}


@end