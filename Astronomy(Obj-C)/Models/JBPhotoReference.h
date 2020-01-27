//
//  JBPhotoReference.h
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-27.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface JBPhotoReference : NSObject

@property (nonatomic, readonly) NSURL *imageURL;
@property (nonatomic, readonly) NSUInteger photoID;
@property (nonatomic, readonly) NSString *cameraName;

- (instancetype) initWithURL:(NSURL *)imageURL
                     photoID:(NSUInteger)photoID
                  cameraName:(NSString *)cameraName;
- (instancetype) initFromDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
