//
//  PhotoFetcherOperation.h
//  AstronomyOBJc
//
//  Created by Kelson Hartle on 7/28/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSIMarsRoverPhotoReference;

NS_ASSUME_NONNULL_BEGIN

@interface PhotoFetcherOperation : NSOperation

@property LSIMarsRoverPhotoReference * marsPhotoReference;
//@property NSURLSession *session;
@property NSData *imageData;
//@property NSURLSessionDataTask *dataTask;

-(instancetype)initWithMarsPhotoReference:(LSIMarsRoverPhotoReference *)marsPhotoReference
//  session:(NSURLSession *)session
                                imageData:(NSData *)imageData;
 //dataTask:(NSURLSessionDataTask *)dataTask;

@end

NS_ASSUME_NONNULL_END
