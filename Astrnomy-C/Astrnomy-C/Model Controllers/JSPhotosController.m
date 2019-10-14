//
//  JSPhotosController.m
//  Astrnomy-C
//
//  Created by Jeffrey Santana on 10/14/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

#import "JSPhotosController.h"
#import "Astrnomy_C-Swift.h"
#import "JSNasaApi.h"

@interface JSPhotosController ()

@property NSString *baseURLString;
@property NSString *apiKey;
@property (nonatomic, readwrite) NSMutableArray *internalPhotos;

@end

@implementation JSPhotosController

- (instancetype)init {
	self = [super init];
	if (self) {
		_baseURLString = @"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos";
		_apiKey = [[[JSNasaApi alloc] init] apiKey];
		_internalPhotos = [[NSMutableArray alloc] init];
	}
	return self;
}

- (NSArray *)photos {
	return [self.internalPhotos copy];
}

- (void)fetchNasaPhotos:(myCompletion)completion {
	NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:self.baseURLString];
		
		NSArray *queryItems = @[
			[NSURLQueryItem queryItemWithName:@"sol" value:@"1000"],
			[NSURLQueryItem queryItemWithName:@"api_key" value:self.apiKey]
		];
		
		urlComponents.queryItems = queryItems;
		
		NSURL *url = urlComponents.URL;
		NSLog(@"URL: %@", url);
		
		NSURLSessionDataTask *task =
		[[NSURLSession sharedSession] dataTaskWithURL:url
									completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
			
			if (error) {
				NSLog(@"Error fetching forecast: %@", error);
				completion(false);
				return;
			}
			
			// parse the data
			NSError *jsonError = nil;
			NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
			if (jsonError) {
				NSLog(@"JSON Error: %@", jsonError);
				completion(nil);
				return;
			}
			
//			NSLog(@"JSON: %@", json);
			
			NSArray *photos = json[@"photos"];
			if (![photos isKindOfClass:NSNull.self]) {
				for (NSDictionary *photoDict in photos) {
					[self.internalPhotos addObject:[[Photo alloc] initWithDictionary:photoDict]];
				}
				
				
				completion(true);
			}
			
			completion(false);
		}];
		[task resume];
}

@end
