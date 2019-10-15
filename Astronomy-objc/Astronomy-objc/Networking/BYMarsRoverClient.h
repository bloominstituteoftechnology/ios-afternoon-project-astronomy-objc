//
//  BYMarseRoverClient.h
//  Astronomy-objc
//
//  Created by Bradley Yin on 10/14/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BYMarsRover;
@class BYMarsPhotoReference;

typedef void (^BYRoverCompletionBlock)(BYMarsRover *, NSError *);
typedef void (^BYPhotoReferenceCompletionBlock)(NSArray<BYMarsPhotoReference *> *, NSError *);
typedef void (^BYImageCompletionBlock)(NSData *, NSError *);

@interface BYMarsRoverClient : NSObject
- (void)fetchMarsRoverWithName:(NSString *)name completionBlock:(BYRoverCompletionBlock)completionBlock;
- (void)fetchPhotosFromRover:(BYMarsRover *)rover onSol:(NSNumber *)sol completionBlock:(BYPhotoReferenceCompletionBlock)completionBlock;
- (void)fetchImageFromPhotoURL:(NSURL *)photoURL completionBlock:(BYImageCompletionBlock)completionBlock;

@end

