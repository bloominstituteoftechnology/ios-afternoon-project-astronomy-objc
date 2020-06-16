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
    [self.manifests removeAllObjects];
    
    NSURL *baseURL = [[NSURL URLWithString:baseURLString] URLByAppendingPathComponent:@"manifests/curiosity"];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:NO];
    
    urlComponents.queryItems = @[
        
        [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey]
    ];
    
    NSURL *requestURL = urlComponents.URL;
    
    NSURLSessionTask *task = [NSURLSession.sharedSession dataTaskWithURL:requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            completionBlock(error);
            return;
        }
        
        if (!data) {
            completionBlock(errorWithMessage(@"Error receiving data from manifest fetch request", 1));
            return;
        }
        
        NSError *jsonError = nil;
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            completionBlock(jsonError);
            return;
        }
        
        NSDictionary *manifestDict = json[@"photo_manifest"];
        NSArray *photos = manifestDict[@"photos"];
        
        for (NSDictionary *photoDict in photos) {
            NSNumber *nsSolID = photoDict[@"sol"];
            if([nsSolID isKindOfClass:[NSNull class]]) { nsSolID = nil; }
            
            NSNumber *nsPhotoCount = photoDict[@"total_photos"];
            if([nsPhotoCount isKindOfClass:[NSNull class]]) { nsPhotoCount = nil; }
            
            NSArray<NSString *> *camerasDict = photoDict[@"cameras"];
            if([camerasDict isKindOfClass:[NSNull class]]) { camerasDict = nil; }
            
            if (nsSolID && nsPhotoCount && camerasDict) {
                CMDManifest *newManifest = [[CMDManifest alloc] initWithSolID:nsSolID.intValue photoCount:nsPhotoCount.intValue cameras:camerasDict];
                
                [self.manifests addObject:newManifest];
            }
        }
        
        completionBlock(nil);
    }];
    
    [task resume];
}

- (void)fetchSolByManifest:(CMDManifest *)manifest completionBlock:(void (^)(NSError *))completionBlock {
    
    [self.marsPhotos removeAllObjects];
    
    NSURL *baseURL = [[NSURL URLWithString:baseURLString] URLByAppendingPathComponent:@"rovers/curiosity/photos"];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:NO];
    
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"sol" value:[NSString stringWithFormat:@"%d", manifest.solID]],
        [NSURLQueryItem queryItemWithName:@"api_key" value:apiKey]
    ];
    
    NSURL *requestURL = urlComponents.URL;
    
    NSURLSessionTask *task = [NSURLSession.sharedSession dataTaskWithURL:requestURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            completionBlock(error);
            return;
        }
        
        if (!data) {
            completionBlock(errorWithMessage(@"Error receiving data from sol fetch request", 1));
            return;
        }
        
        NSError *jsonError = nil;
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            completionBlock(jsonError);
            return;
        }
        
        [self.marsPhotos removeAllObjects];
        
        NSArray *photosArray = json[@"photos"];
        
        for (NSDictionary *photoDict in photosArray) {
            NSNumber *sol = photoDict[@"sol"];
            if([sol isKindOfClass:[NSNull class]]) { sol = nil; }
            
            NSDictionary *camera = photoDict[@"camera"];
            NSString *cameraName = camera[@"name"];
            if([cameraName isKindOfClass:[NSNull class]]) { cameraName = nil; }
            
            NSString *cameraFullName = camera[@"full_name"];
            if([cameraFullName isKindOfClass:[NSNull class]]) { cameraFullName = nil; }
            
            NSDate *photoDate = [self.dateFormatter dateFromString:photoDict[@"earth_date"]];
            if([photoDate isKindOfClass:[NSNull class]]) { photoDate = nil; }
            
            NSURL *imageURL = [NSURL URLWithString:photoDict[@"img_src"]];
            if([imageURL isKindOfClass:[NSNull class]]) { imageURL = nil; }
            if (imageURL) {
                NSURLComponents *components = [NSURLComponents componentsWithURL:imageURL resolvingAgainstBaseURL:YES];
                components.scheme = @"https";
                imageURL = components.URL;
            }
            
            NSDictionary *rover = photoDict[@"rover"];
            NSNumber *roverID = rover[@"id"];
            if([roverID isKindOfClass:[NSNull class]]) { roverID = nil; }
            
            NSString *roverName = rover[@"name"];
            if([roverName isKindOfClass:[NSNull class]]) { roverName = nil; }
            
            NSNumber *photoID = photoDict[@"id"];
            if([photoID isKindOfClass:[NSNull class]]) { photoID = nil; }
            
            if (sol && cameraName && cameraFullName && photoDate && imageURL && roverID && roverName && photoID) {
                MarsPhoto *newPhoto = [[MarsPhoto alloc] initWithSol:sol.intValue cameraName:cameraName cameraFullName:cameraFullName photoDate:photoDate imageURL:imageURL roverID:roverID.intValue roverName:roverName photoID:photoID.intValue];
                [self.marsPhotos addObject:newPhoto];
            }

        }
        
        completionBlock(nil);
    }];
    
    [task resume];
}

@end
