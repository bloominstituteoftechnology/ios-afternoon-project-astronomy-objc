//
//  EGCAstronomyCollectionViewCell.m
//  AstronomyObjectiveC
//
//  Created by Enrique Gongora on 4/20/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

#import "EGCAstronomyCollectionViewCell.h"

@implementation EGCAstronomyCollectionViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
    self.imageView.image = [UIImage imageNamed:@"Moon"];
}

@end
