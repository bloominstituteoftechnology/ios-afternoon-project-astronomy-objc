//
//  EJSApiClient.h
//  Swift
//
//  Created by Enzo Jimenez-Soto on 7/21/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EJSNasaManifest;
@class EJSSolPhoto;

typedef void (^EJSManifestFetcherCompletionBlock)(EJSNasaManifest * manifest, NSError *error);

typedef void (^EJSSolPhotoFetcherCompletionBlock)(NSArray<EJSSolPhoto *> *solPhotos, NSError *error);

typedef void (^EJSPhotoFetcherCompletionBlock)(NSData *photoData, NSError *error);

@interface EJSApiClient : NSObject

-(void)fetchManifestWithCompletionBlock:(EJSManifestFetcherCompletionBlock)completionBlock;

-(void)fetchSolPhotosForRover:(NSString *)roverName solId:(NSNumber *)solId completionBlock:(EJSSolPhotoFetcherCompletionBlock)completionBlock;

-(void)fetchPhotoAtURL:(NSString *)urlString completionBlock:(EJSPhotoFetcherCompletionBlock)completionBlock;

@end
