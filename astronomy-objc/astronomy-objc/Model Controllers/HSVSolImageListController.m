//
//  HSVSolImageListController.m
//  astronomy-objc
//
//  Created by Hector Steven on 7/23/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

#import "HSVSolImageListController.h"


@interface HSVSolImageListController ()

@property (nonatomic, copy) NSMutableArray *internalSolImageList;

@end

@implementation HSVSolImageListController

- (instancetype)init
{
	self = [super init];
	if (self) {
		_internalSolImageList = [[NSMutableArray alloc] init];
	}
	return self;
}


static NSString *baseSolImagesUrl = @"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=22&api_key=3Gj8mRPLnRIWJUHtRHrcuy5ZL57sOwNaLX35rBCG";

- (void)fetchImageListWithSol:(int)sol Completion:(void (^)(NSError *error ))completion{
	NSString *newbase = [[NSString alloc] initWithFormat:@"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=%i&api_key=3Gj8mRPLnRIWJUHtRHrcuy5ZL57sOwNaLX35rBCG", sol];
	
	NSURL *url = [[NSURL alloc] initWithString:newbase];
	
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
		
		[self.internalSolImageList addObjectsFromArray:photosArr];

//		for(NSDictionary *dic in photosArr) {
//
//			NSString *imgSrc = dic[@"img_src"];
//
//				//HSVSolPhoto *solPhot = [HSVSolPhoto alloc] initWithImg_src:<#(NSString * _Nonnull)#> sol:<#(NSString * _Nonnull)#> earthDate:<#(NSString * _Nonnull)#> cameraName:<#(NSString * _Nonnull)#> roverName:<#(NSString * _Nonnull)#>
//			NSLog(@"%@", imgSrc);
//		}
//
		NSLog(@"count: %li", [photosArr count]);
		completion(nil);
	}] resume];
}


- (void)Test{
	NSLog(@"Test this");
}

@end
