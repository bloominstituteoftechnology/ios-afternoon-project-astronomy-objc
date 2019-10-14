//
//  JSPhotosController.h
//  Astrnomy-C
//
//  Created by Jeffrey Santana on 10/14/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Photos;
typedef void(^myCompletion)(BOOL);

NS_SWIFT_NAME(PhotosController)
@interface JSPhotosController : NSObject

@property (nonatomic, readonly) NSArray *photos;

- (void)fetchNasaPhotos:(myCompletion)completion;

@end
