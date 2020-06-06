//
//  LSIImageCollectionViewCell.m
//  Astronomy
//
//  Created by David Wright on 6/3/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

#import "LSIImageCollectionViewCell.h"

@interface LSIImageCollectionViewCell ()

@property (nonatomic, readwrite, nonnull) IBOutlet UIImageView *imageView;

@end

@implementation LSIImageCollectionViewCell

// Custom getter/setter for image
@synthesize image = _image;

- (UIImage *)image
{
    return _image;
}

- (void)setPhoto:(UIImage * _Nonnull)image
{
    _image = image;
    
    if (image) {
        self.imageView.image = image;
    } else {
        self.imageView.image = [UIImage imageNamed:@"MarsPlaceholder"];
    }
}

@end
