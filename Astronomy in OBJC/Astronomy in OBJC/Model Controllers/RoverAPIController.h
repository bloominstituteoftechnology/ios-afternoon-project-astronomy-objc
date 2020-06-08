//
//  RoverAPIController.h
//  Astronomy in OBJC
//
//  Created by Sal B Amer on 6/4/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MarsPhotos;

////fwd class declaration for MarsRoverModel
//@class MarsRover;

typedef void (^MarsPhotoCompletion)(NSArray<MarsPhotos *> *_Nullable photos, NSError *_Nullable error);
typedef void (^MarsSinglePhotoCompletion)(NSData *_Nullable photoData, NSError *_Nullable error);


NS_ASSUME_NONNULL_BEGIN

@interface RoverAPIController : NSObject

//@property (nonatomic, readonly, copy) NSArray<MarsRover *> *solPhotos;

@property (nonatomic, nullable) NSArray<MarsPhotos *> *photos;

- (instancetype)initWithPhotos:(NSMutableArray *) photos;

- (void)fetchMarsPhotosFromSol:(NSNumber *) sol
               completionBlock:(MarsPhotoCompletion) completionBlock;

- (void)fetchImagesForPhotoRef:(MarsPhotos *) photoReferences
               completionBlock:(MarsSinglePhotoCompletion) completionBlock;



@end

NS_ASSUME_NONNULL_END
