//
//  CMDMarsPhotoController.m
//  Astronomy
//
//  Created by Chris Dobek on 6/15/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

#import "CMDMarsPhotoController.h"
#import <UIKit/UIKit.h>
#import "LSIErrors.h"
#import "CMDManifest.h"
#import "Astronomy-Swift.h"

NSString *baseURLString = @"https://api.nasa.gov/mars-photos/api/v1/";
NSString *apiKey = @"b0VhVkFEftyIToMt1QXFOM1geGh0CFUvQDRdptWi";

@interface CMDMarsPhotoController ()

@property (nonatomic, readonly) NSDateFormatter *dateFormatter;

@end

@implementation CMDMarsPhotoController

- (instancetype)init {
    self = [super init];
    if (self) {
        _marsPhotos = [[NSMutableArray<MarsPhoto *> alloc] init];
        _manifests = [[NSMutableArray<CMDManifest *> alloc] init];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        _dateFormatter = formatter;
    }
    
    return self;
}

- (void)fetchingSinglePhotoWithURL:(NSURL *)imageURL completionBlock:(void (^)(NSError *, UIImage *))completionBlock {
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:imageURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            completionBlock(error, nil);
            return;
        }
        
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            completionBlock(nil, image);
            return;
        }
    }];
    
    [task resume];
}

- (void)fetchManifest:(void (^)(NSError *))completionBlock {
    
}

- (void)fetchSolByManifest:(CMDManifest *)manifest completionBlock:(void (^)(NSError *))completionBlock {
    
}

@end
