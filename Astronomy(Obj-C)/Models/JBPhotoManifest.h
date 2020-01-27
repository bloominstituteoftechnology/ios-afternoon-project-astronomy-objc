//
//  JBPhotoManifest.h
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-27.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JBSol;
@class JBPhotoController;


NS_ASSUME_NONNULL_BEGIN

@interface JBPhotoManifest : NSObject

@property (nonatomic, readonly) NSString *roverName;
@property (nonatomic, readonly) NSArray<JBSol *> *sols;

- (instancetype) initWithName:(NSString *)roverName
                         sols:(NSArray<JBSol *> *)sols
              photoController:(JBPhotoController *)photoController;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary
                    photoController:(JBPhotoController *)photoController;

@end

NS_ASSUME_NONNULL_END
