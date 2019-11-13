//
//  DMNPhotoCollectionViewCell.m
//  Astronomy
//
//  Created by Andrew R Madsen on 11/28/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import "LSIImageCollectionViewCell.h"

@implementation LSIImageCollectionViewCell

- (void)prepareForReuse
{
	[super prepareForReuse];
	
	self.imageView.image = [UIImage imageNamed:@"MarsPlaceholder"];
}

@end
