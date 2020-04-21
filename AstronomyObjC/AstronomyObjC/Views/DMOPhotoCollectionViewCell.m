//
//  PhotoCollectionViewCell.m
//  AstronomyObjC
//
//  Created by morse on 1/26/20.
//  Copyright © 2020 morse. All rights reserved.
//

#import "DMOPhotoCollectionViewCell.h"

@implementation DMOPhotoCollectionViewCell

- (void)prepareForReuse {
    self.urlTextView.text = @"";
    [super prepareForReuse];
}

@end
