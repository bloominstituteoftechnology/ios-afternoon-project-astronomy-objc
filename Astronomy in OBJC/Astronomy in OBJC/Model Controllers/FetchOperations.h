//
//  FetchOperations.h
//  Astronomy-in-OBJC
//
//  Created by Sal B Amer on 6/4/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MarsPhotos;

NS_ASSUME_NONNULL_BEGIN

@interface FetchOperations : NSOperation

@property (nonatomic, copy, readonly, nullable) NSData* imageData;
@property (nonatomic) NSError *fetchError;
- (nonnull instancetype)initWithPhotoReference:(MarsPhotos *_Nonnull)photo;


@end

NS_ASSUME_NONNULL_END
