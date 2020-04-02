//
//  LSIImageCollectionViewCell.m
//  Astronomy-Hybrid
//
//  Created by Isaac Lyons on 12/17/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

#import "LSIImageCollectionViewCell.h"

@implementation LSIImageCollectionViewCell

- (void)prepareForReuse {
    [self.imageView setImage:nil];
    [super prepareForReuse];
}

@end
