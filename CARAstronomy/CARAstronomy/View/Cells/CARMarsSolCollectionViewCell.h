//
//  CARMarsSolCollectionViewCell.h
//  CARAstronomy
//
//  Created by Chad Rutherford on 2/25/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CARMarsSol.h"
#import "CARFetchPhotoOperation.h"


typedef void(^CARMarsSolColletionViewCellCompletion) (void);

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(MarsSolCollectionViewCell)
@interface CARMarsSolCollectionViewCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UIImageView *solImageView;
@property (nonatomic, readonly) CARMarsSol *sol;
@property (nonatomic, nullable) CARFetchPhotoOperation *photoFetchOperation;

- (void)configureCellWithSol:(CARMarsSol *)sol;

@end

NS_ASSUME_NONNULL_END
