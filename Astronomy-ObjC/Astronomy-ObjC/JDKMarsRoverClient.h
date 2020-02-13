//
//  JDKMarsRoverClient.h
//  Astronomy-ObjC
//
//  Created by John Kouris on 2/12/20.
//  Copyright © 2020 John Kouris. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JDKMarsRover;
@class MarsPhotoReference;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(MarsRoverClient)
@interface JDKMarsRoverClient : NSObject

@property (nonnull, readonly) NSURL *baseURL;
@property (nonnull, readonly) NSString *apiKey;

- (void)fetchPhotosFromRover:(nonnull JDKMarsRover *)rover
                       onSol:(int)sol
                  completion:(void (^_Nonnull)(NSArray<MarsPhotoReference *> * _Nullable photos, NSError * _Nullable error))completion;

- (void)fetchMarsRoverNamed:(nonnull NSString *)name
                 completion:(void (^_Nonnull)(JDKMarsRover * _Nullable, NSError * _Nullable error))completion;

- (void)fetchFromURL:(nonnull NSURL *)url
          completion:(void (^_Nonnull)(NSDictionary * _Nullable dictionary, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
