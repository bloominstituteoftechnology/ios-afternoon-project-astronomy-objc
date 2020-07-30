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

@property UIImage *imageData;
@property (nonatomic, nullable) NSURL *photoURL;


- (nonnull instancetype)initWithPhotoURL:(nonnull NSURL *)photoURL;
+ (instancetype)initWithMarsPhotoReference:(nonnull LSIMarsRoverPhotoReference *)marsPhotoReference;

-(void)start;
-(void)cancel;

@end

NS_ASSUME_NONNULL_END
