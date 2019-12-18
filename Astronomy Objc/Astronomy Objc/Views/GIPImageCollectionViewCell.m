//
//  GIPImageCollectionViewCell.m
//  Astronomy Objc
//
//  Created by Gi Pyo Kim on 12/17/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

#import "GIPImageCollectionViewCell.h"

@interface GIPImageCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation GIPImageCollectionViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
    self.imageView.image = [UIImage imageNamed:@"MarsPlaceholder"];
}

@end
