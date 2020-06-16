//
//  PDMFetchRoverImageOperation.h
//  Obj-C-Astronomy
//
//  Created by Patrick Millet on 6/16/20.
//  Copyright © 2020 PatrickMillet79. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PDMMarsRoverController;

NS_ASSUME_NONNULL_BEGIN

@interface PDMFetchRoverImageOperation : NSOperation

@property (nonatomic, nullable) NSData *imgData;

- (instancetype)initWithImageURLString:(NSString *)imageURLString;

@end

NS_ASSUME_NONNULL_END
