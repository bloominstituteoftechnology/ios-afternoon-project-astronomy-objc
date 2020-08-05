//
//  PhotoFetcherOperation.h
//  AstronomyOBJc
//
//  Created by Kelson Hartle on 7/28/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LSIMarsRoverPhotoReference;

NS_ASSUME_NONNULL_BEGIN

@interface PhotoFetcherOperation : NSOperation

@property (nonatomic, copy, readonly, nullable) NSData* imageData;

- (nonnull instancetype)initWithPhotoReference:(LSIMarsRoverPhotoReference *_Nonnull)photoReference;

@end

NS_ASSUME_NONNULL_END
