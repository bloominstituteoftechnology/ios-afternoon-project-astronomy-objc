//
//  ImageCollectionViewCell.m
//  Astronomy-Hybrid
//
//  Created by Bobby Keffury on 2/12/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@interface ImageCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ImageCollectionViewCell

- (void) prepareForReuse
{
    [super prepareForReuse];
    
    _imageView.image = [UIImage imageNamed:@"MarsPlaceholder"];
}

@end
