//
//  PhotosCollectionViewCell.m
//  Astronomy-Interoperability
//
//  Created by Alex Thompson on 6/6/20.
//  Copyright © 2020 Christian Lorenzo. All rights reserved.
//

#import "PhotosCollectionViewCell.h"
#import "TLPhotoController.h"
#import "Astronomy_Interoperability-Swift.h"

@implementation PhotosCollectionViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageBackgroundView.layer.cornerRadius = 8;
    _imageBackgroundView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _imageBackgroundView.layer.shadowOpacity = 1;
    _imageBackgroundView.layer.shadowOffset = CGSizeMake(0, 0);
    _imageBackgroundView.layer.shadowRadius = 3;
    _imageBackgroundView.layer.masksToBounds = NO;
    _imageBackgroundView.backgroundColor = [UIColor whiteColor];
    _imageView.layer.cornerRadius = 8;
    _imageView.clipsToBounds = YES;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.imageView.image = nil;
}

@end
