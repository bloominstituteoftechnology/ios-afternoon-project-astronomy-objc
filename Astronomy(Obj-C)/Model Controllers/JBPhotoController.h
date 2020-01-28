//
//  JBPhotoController.h
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-27.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JBPhotoReference;
@class JBSol;


NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(PhotoController)
@interface JBPhotoController : NSObject

@property (nonatomic, readonly) NSArray<JBSol *> *sols;

- (instancetype)init;

- (void)fetchMissionManifestWithCompletion:(void (^)(NSError * _Nullable))completion;
- (void)fetchPhotoReferencesForSol:(JBSol *)sol
                        completion:(void (^)(NSArray<JBPhotoReference *> * _Nullable,
                                             NSError * _Nullable))completion;
- (void)fetchPhotoForReference:(JBPhotoReference *)photoRef
                    completion:(void (^)(UIImage * _Nullable,
                                         NSError * _Nullable))completion;
- (void)cancelPhotoFetchForReference:(JBPhotoReference * _Nullable)photoRef;

@end

NS_ASSUME_NONNULL_END
