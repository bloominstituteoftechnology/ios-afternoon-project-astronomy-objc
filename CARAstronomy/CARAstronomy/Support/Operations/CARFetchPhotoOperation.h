//
//  CARFetchPhotoOperation.h
//  CARAstronomy
//
//  Created by Chad Rutherford on 2/25/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "CARMarsSol.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(FetchPhotoOperation)
@interface CARFetchPhotoOperation : NSOperation

@property (nonatomic, nonnull, readonly) CARMarsSol *sol;
@property (nonatomic, nullable) UIImage *image;

- (instancetype)initWithSol:(CARMarsSol *)sol;

@end

NS_ASSUME_NONNULL_END
