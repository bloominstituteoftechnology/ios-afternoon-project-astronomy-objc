////
////  HSVSolImageListController.m
////  astronomy-objc
////
////  Created by Hector Steven on 7/23/19.
////  Copyright © 2019 Hector Steven. All rights reserved.
////
//
//#import "HSVSolImageListController.h"
//#import "astronomy_objc-Swift.h"
//
//@interface HSVSolImageListController ()
//
//@property (nonatomic, copy) NSMutableArray *internalSolImageList;
//
//@end
//
//@implementation HSVSolImageListController
//
//- (instancetype)init
//{
//	self = [super init];
//	if (self) {
//		_internalSolImageList = [[NSMutableArray alloc] init];
//	}
//	return self;
//}
//
//- (NSArray *)solImageList{
//	return [_internalSolImageList copy];
//}
//
//static NSString *baseSolImagesUrl = @"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=22&api_key=3Gj8mRPLnRIWJUHtRHrcuy5ZL57sOwNaLX35rBCG";
//
//- (void)fetchImageListWithSol:(int)sol Completion:(void (^)(NSArray<SolPhoto *> *, NSError *error ))completion{
//	NSString *newbase = [[NSString alloc] initWithFormat:@"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=%i&api_key=3Gj8mRPLnRIWJUHtRHrcuy5ZL57sOwNaLX35rBCG", sol];
//
//	NSURL *url = [[NSURL alloc] initWithString:newbase];
//
//	NSLog(@"url: %@", url);
//
//	[[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//		if (error){
//			completion(nil, error);
//			return;
//		}
//
//		NSError *jsonError ;
//
//		NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
//
//		if (jsonError){
//			NSLog(@"error with NSJSONSerialization: %@", jsonError);
//			completion(nil, jsonError);
//			return;
//		}
//
//		NSArray *photosArr = jsonDictionary[@"photos"];
//
////		NSLog(@"%@", photosArr[2]);
//
//		NSLog(@"%@", photosArr[2][@"camera"][@"name"]);
//
////		for (NSDictionary *dict in photosArr) {
////			SolPhoto *solPhoto = [[HSVSolPhoto alloc] initWithDictionary:dict];
////			NSLog(@"camera name: %@", [solPhoto img_src]);
////		}
//
//
//		//[self.internalSolImageList addObjectsFromArray:photosArr];
//		completion(nil, nil);
//
////		NSLog(@"count: %li", [photosArr count]);
//	}] resume];
//}
//
//- (void)fetchImageWithUrl:(NSURL *)url Completion:(void (^)(NSError *error ))completion{
//
//	NSLog(@"url: %@", url);
//	
//	[[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//		if (error){
//			completion(error);
//			return;
//		}
//		
////		NSError *jsonError ;
////
////		NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
////		
////		if (jsonError){
////			NSLog(@"error with NSJSONSerialization: %@", jsonError);
////			completion(jsonError);
////			return;
////		}
////		
////		NSArray *photosArr = jsonDictionary[@"photos"];
////		[self.internalSolImageList addObjectsFromArray:photosArr];
////		completion(nil);
////		
////			//		NSLog(@"count: %li", [photosArr count]);
//	}] resume];
//}
//
//
//
//
//
//
//
//
//
//
//- (void)Test{
//	NSLog(@"Test this");
//}
//
//@end
