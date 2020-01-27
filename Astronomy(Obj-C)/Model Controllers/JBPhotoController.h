//
//  JBPhotoController.h
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-27.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JBPhotoReference;
@class JBSol;


NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(PhotoController)
@interface JBPhotoController : NSObject

@property (nonatomic, readonly) NSArray<JBSol *> *sols;

- (instancetype)init;

- (void)fetchPhotoReferencesForSol:(JBSol *)sol
                        completion:(void (^)(NSMutableArray<JBPhotoReference *> *,
                                             NSError *))completion;

@end

NS_ASSUME_NONNULL_END
