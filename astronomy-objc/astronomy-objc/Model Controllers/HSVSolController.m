//
//  HSVSolController.m
//  astronomy-objc
//
//  Created by Hector Steven on 7/22/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

#import "HSVSolController.h"
#import "../Models/HSVSol.h"
#import "astronomy_objc-Swift.h"

@interface HSVSolController ()

@property (nonatomic, copy) NSMutableArray<HSVSol *> *internalSol;

@end


@implementation HSVSolController

- (instancetype)init
{
	self = [super init];
	if (self) {
		_internalSol = [[NSMutableArray alloc] init];
		
	}
	return self;
}

static NSString *baseSolUrl = @"https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity?api_key=3Gj8mRPLnRIWJUHtRHrcuy5ZL57sOwNaLX35rBCG";



- (NSArray *)Sols{
	return self.internalSol;
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
