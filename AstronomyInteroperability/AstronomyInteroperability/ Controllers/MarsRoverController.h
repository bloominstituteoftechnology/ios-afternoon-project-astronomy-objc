//
//  MarsRoverController.h
//  AstronomyInteroperability
//
//  Created by Nonye on 7/21/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LSIMarsRoverClient;
@class Photos;

typedef void(^ManifestCompletionBlock)(LSIMarsRoverClient *_Nullable rover, NSError *_Nullable error);

typedef void(^FetchPhotosCompletionBlock)(Photos *_Nullable rover, NSError *_Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface MarsRoverController : NSObject

- (void)fetchManifestWithCompletionHandler:(ManifestCompletionBlock)completionBlock;

- (void)fetchPhotosForSol:(int)sol WithCompletionHandler:(FetchPhotosCompletionBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END


