//
//  TMCNetworkController.h
//  AstronomyObjC
//
//  Created by Christopher Devito on 5/18/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class TMCMarsPhotoReference;

typedef void (^TMCMarsPhotoCompletion)(NSArray<TMCMarsPhotoReference *> *_Nullable photos, NSError *_Nullable error);
typedef void (^TMCMarsSinglePhotoCompletion)(NSData *_Nullable photoData, NSError *_Nullable error);

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(NetworkController)
@interface TMCNetworkController : NSObject

@property (nonatomic, nullable) NSArray<TMCMarsPhotoReference *> *photos;

- (instancetype)initWithPhotos:(NSMutableArray *)photos;

- (void)fetchMarsPhotosOnSol:(NSNumber *)sol
            completionBlock:(TMCMarsPhotoCompletion)completionBlock;

- (void)fetchImageForPhotoReference:(TMCMarsPhotoReference *)photoReference
                completionBlock: (TMCMarsSinglePhotoCompletion)completionBlock;

@end

NS_ASSUME_NONNULL_END
