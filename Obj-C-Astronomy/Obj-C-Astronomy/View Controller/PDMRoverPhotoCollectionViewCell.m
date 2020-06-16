//
//  PDMRoverPhotoControllerCollectionViewCell.m
//  Obj-C-Astronomy
//
//  Created by Patrick Millet on 6/16/20.
//  Copyright © 2020 PatrickMillet79. All rights reserved.
//

#import "PDMRoverPhotoCollectionViewCell.h"

@implementation PDMRoverPhotoCollectionViewCell

- (void)prepareForReuse
{
    self.roverImage.image = [UIImage imageNamed:@"roverImagePlaceholder"];
    
    [super prepareForReuse];
}

@end
