//
//  TLPhotoController.h
//  Astronomy-Interoperability
//
//  Created by Christian Lorenzo on 6/3/20.
//  Copyright © 2020 Christian Lorenzo. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Photo;
@class UIImage;
@class TLManifest;
@interface TLPhotoController : NSObject

//MARK: - Properties:
@property (nonatomic, readonly, nonnull) NSMutableArray<Photo *> *photos;
@property (nonatomic, readonly, nonnull) NSMutableArray<TLManifest *> *manifests;

//MARK: - Methods:
- (void)fetchingSinglePhotoWithURL:(NSURL *_Nonnull)imgSrc
                   completionBlock:(void(^_Nonnull)(NSError * _Nullable error, UIImage * _Nullable image))completionBlock;

- (void)fetchManifest:(void (^_Nonnull)(NSError * _Nullable error))completionBlock;
- (void)fetchSolByManifest:(TLManifest *_Nonnull)manifest
           completionBlock:(void (^_Nonnull)(NSError * _Nullable error))completionBlock;

@end

