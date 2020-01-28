//
//  JBPhotoCollectionViewCell.m
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-27.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import "JBPhotoCollectionViewCell.h"
#import "JBPhotoController.h"
#import "JBPhotoReference.h"


@implementation JBPhotoCollectionViewCell

- (void)prepareForReuse
{
    self.imageView.image = [UIImage imageNamed:@"GraySquare"];
}

@end
