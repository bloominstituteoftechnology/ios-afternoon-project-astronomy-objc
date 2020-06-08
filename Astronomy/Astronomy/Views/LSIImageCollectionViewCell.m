//
//  LSIImageCollectionViewCell.m
//  Astronomy
//
//  Created by David Wright on 6/3/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

#import "LSIImageCollectionViewCell.h"

@implementation LSIImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MarsPlaceholder"]];
        _imageView.frame = self.frame;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
    }
    return self;
}

- (void)prepareForReuse {
    self.imageView.image = [UIImage imageNamed:@"MarsPlaceholder"];
}

@end
