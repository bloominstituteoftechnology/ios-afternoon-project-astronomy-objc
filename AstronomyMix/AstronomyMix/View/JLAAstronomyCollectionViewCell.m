//
//  JLAAstronomyCollectionViewCell.m
//  AstronomyMix
//
//  Created by Jorge Alvarez on 3/27/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

#import "JLAAstronomyCollectionViewCell.h"

@implementation JLAAstronomyCollectionViewCell

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.imageView.image = [UIImage imageNamed:@"park"];
}

@end
