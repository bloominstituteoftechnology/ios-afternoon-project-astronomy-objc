//
//  TMCFetchOperations.h
//  AstronomyObjC
//
//  Created by Christopher Devito on 5/19/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class TMCMarsPhotoReference;

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(PhotoFetchOperation)

@interface TMCFetchOperations : NSOperation

@property (nonatomic, copy, readonly, nullable) NSData* imageData;
- (nonnull instancetype)initWithPhotoReference:(TMCMarsPhotoReference *_Nonnull)photo;

@end

NS_ASSUME_NONNULL_END
