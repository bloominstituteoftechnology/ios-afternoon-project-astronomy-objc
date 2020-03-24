//
//  MBMRoverController.h
//  Astronomy-Objc
//
//  Created by Michael on 3/23/20.
//  Copyright © 2020 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MissionManifest;
@class MBMPhoto;
@class MBMPhotoResults;

typedef void (^MBMManifestFetcherCompletion) (MissionManifest * _Nullable manifest, NSError * _Nullable error);

typedef void (^MBMPhotoFetcherCompletion) (NSArray<MBMPhoto *> * _Nullable photos, NSError * _Nullable error);


NS_SWIFT_NAME(RoverController)
@interface MBMRoverController : NSObject

@property (nonatomic) NSArray<MBMPhoto *> * _Nullable photos;

-(void)fetchManifestWithRoverName:(NSString * _Nonnull)roverName
                  completionBlock:(MBMManifestFetcherCompletion _Nullable)completion;

-(void)fetchPhotosWithSol:(int)sol
               roverName:(NSString *_Nonnull)roverName
        completionBlock:(MBMPhotoFetcherCompletion _Nullable)completion;

@end


