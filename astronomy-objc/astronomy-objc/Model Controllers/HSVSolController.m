//
//  HSVSolController.m
//  astronomy-objc
//
//  Created by Hector Steven on 7/22/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

#import "HSVSolController.h"
#import "../Models/HSVSol.h"
#import "../Models/HSVSolPhotDescription.h"
#import "astronomy_objc-Swift.h"

@interface HSVSolController ()

@property (nonatomic, copy) NSMutableArray<HSVSol *> *internalSol;
@property (nonatomic, copy) NSMutableArray<HSVSolPhotDescription *> *internalPhotosDescriptionList;
@end


@implementation HSVSolController

- (instancetype)init
{
	self = [super init];
	if (self) {
		_internalSol = [[NSMutableArray alloc] init];
		_internalPhotosDescriptionList = [[NSMutableArray alloc] init];
	}
	return self;
}

static NSString *baseSolUrl = @"https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity?api_key=3Gj8mRPLnRIWJUHtRHrcuy5ZL57sOwNaLX35rBCG";



- (NSArray *)Sols{
	return self.internalSol;
}

- (NSArray *)SolPhotosDescription{
	return self.internalPhotosDescriptionList;
}


- (void)fetchSolsWithCompletion:(void (^)(NSError *error))completion{
	
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
		
		NSArray *solArr = jsonDictionary[@"photo_manifest"][@"photos"];

		[self getInternalSolsWitArr:solArr];
		
		
		completion(nil);
	}] resume];
	
	
}




- (void)fetchImageListWithSol:(int)sol Completion:(void (^)(NSError *error ))completion {
	
	NSString *newbase = [[NSString alloc] initWithFormat:@"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=%i&api_key=3Gj8mRPLnRIWJUHtRHrcuy5ZL57sOwNaLX35rBCG", sol];
	NSURL *url = [[NSURL alloc] initWithString:newbase];
	NSLog(@"url: %@", url);

	[[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
		if (error){
			completion(error);
			return;
		}
		NSError *jsonError;
		
		NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

		if (jsonError){
			NSLog(@"error with NSJSONSerialization: %@", jsonError);
			completion(jsonError);
			return;
		}
		
//		NSLog(@"Dictionary is: \n%@", jsonDictionary[@"photos"][0]);
		NSArray *jsonArr  = jsonDictionary[@"photos"];
		
		for(int i = 0; i < (int)jsonArr.count; i++) {
			NSString *sol = jsonDictionary[@"photos"][i][@"sol"];
			NSString *img_src = jsonDictionary[@"photos"][i][@"img_src"];
			NSString *earthDate = jsonDictionary[@"photos"][i][@"earth_date"];
			NSString *cameraName = jsonDictionary[@"photos"][i][@"camera"][@"name"];
			NSString *rovername = jsonDictionary[@"photos"][i][@"camera"][@"name"];
			
			HSVSolPhotDescription *spd = [[HSVSolPhotDescription alloc] initWithSol:sol img_src:img_src earthDate:earthDate cameraName:cameraName roverName:rovername];
			[self.internalPhotosDescriptionList addObject:spd];
		}
		
		completion(nil);
	}] resume];
	
}

- (void)fetchImageWithURL:(NSURL *)url Completion:(void (^)(NSError *error ))completion {
	
	NSLog(@"%@", url);
	[[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
		if (error){
			completion(error);
			return;
		}
		
		
		
		
		
		completion(nil);
	}] resume];
	  
}



#pragma mark - Private

- (void)getInternalSolsWitArr:(NSArray *)arr {
	NSInteger solCount = [arr count];
	for(int i = 0; i < (int)solCount; i++) {
		
		int solNumber = [arr[i][@"sol"] intValue];
		int totalPhotos = [arr[i][@"total_photos"] intValue];
		NSString *earthDate = arr[i][@"earth_date"];
		NSArray *cameras = arr[i][@"cameras"];
		
		HSVSol *sol = [[HSVSol alloc] initWithSol:solNumber totalPhotos:totalPhotos earthDate:earthDate cameras:cameras];
		[self.internalSol addObject:sol];
	}
	
	NSLog(@"%li", [self.internalSol count]);
}


@end
