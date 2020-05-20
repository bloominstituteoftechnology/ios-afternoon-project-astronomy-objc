//
//  SSSPhotoCollectionViewCell.h
//  Astronomy
//
//  Created by Shawn Gee on 5/19/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSSMarsPhoto;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(PhotoCollectionViewCell)
@interface SSSPhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic) SSSMarsPhoto *photo;

@end

NS_ASSUME_NONNULL_END
