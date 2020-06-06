//
//  PhotosCollectionViewCell.h
//  Astronomy-Interoperability
//
//  Created by Alex Thompson on 6/6/20.
//  Copyright © 2020 Christian Lorenzo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TLPhotoController;
@class Photo;

NS_ASSUME_NONNULL_BEGIN

@interface PhotosCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) Photo *photo;
@property (strong, nonatomic) IBOutlet UIView *imageBackgroundView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *textLabel;

@end

NS_ASSUME_NONNULL_END
