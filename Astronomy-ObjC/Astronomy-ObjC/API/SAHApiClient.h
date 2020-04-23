//
//  SAHApiClient.h
//  Astronomy-ObjC
//
//  Created by scott harris on 4/20/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SAHNasaManifest;
@class SAHSolPhoto;

typedef void (^SAHManifestFetcherCompletionBlock)(SAHNasaManifest * manifest, NSError *error);

typedef void (^SAHSolPhotoFetcherCompletionBlock)(NSArray<SAHSolPhoto *> *solPhotos, NSError *error);

typedef void (^SAHPhotoFetcherCompletionBlock)(NSData *photoData, NSError *error);

@interface SAHApiClient : NSObject

-(void)fetchManifestWithCompletionBlock:(SAHManifestFetcherCompletionBlock)completionBlock;

-(void)fetchSolPhotosForRover:(NSString *)roverName solId:(NSNumber *)solId completionBlock:(SAHSolPhotoFetcherCompletionBlock)completionBlock;

-(void)fetchPhotoAtURL:(NSString *)urlString completionBlock:(SAHPhotoFetcherCompletionBlock)completionBlock;

@end
