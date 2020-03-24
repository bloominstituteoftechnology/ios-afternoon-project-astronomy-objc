//
//  SolPhotosCollectionViewCell.h
//  Astronomy-Objc
//
//  Created by Michael on 3/24/20.
//  Copyright © 2020 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MBMPhoto;

@interface SolPhotosCollectionViewCell : UICollectionViewCell

@property (nonatomic) MBMPhoto *photo;

-(void)updateViews;

@end

NS_ASSUME_NONNULL_END
