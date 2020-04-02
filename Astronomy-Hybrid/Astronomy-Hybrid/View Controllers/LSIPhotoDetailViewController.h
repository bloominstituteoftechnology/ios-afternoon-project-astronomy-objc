//
//  LSIPhotoDetailViewController.h
//  Astronomy-Hybrid
//
//  Created by Isaac Lyons on 12/17/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MarsPhotoReference;

NS_SWIFT_NAME(PhotoDetailViewController)
@interface LSIPhotoDetailViewController : UIViewController

@property MarsPhotoReference *photoReference;
@property UIImage *image;

@end
