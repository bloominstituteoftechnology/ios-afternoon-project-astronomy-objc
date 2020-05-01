//
//  RoverPhotoCollectionViewCell.m
//  Astronomy-objc
//
//  Created by Dillon P on 4/28/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

#import "RoverPhotoCollectionViewCell.h"

@implementation RoverPhotoCollectionViewCell

- (void)prepareForReuse
{
    self.roverImage.image = [UIImage imageNamed:@"roverImagePlaceholder"];
    
    [super prepareForReuse];
}

@end
