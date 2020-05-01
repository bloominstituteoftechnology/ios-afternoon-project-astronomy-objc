//
//  FetchRoverImageOperation.h
//  Astronomy-objc
//
//  Created by Dillon P on 4/29/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MarsRoverController;

NS_ASSUME_NONNULL_BEGIN

@interface FetchRoverImageOperation : NSOperation

@property (nonatomic, nullable) NSData *imgData;
//@property (nonatomic) MarsRoverController *marsRoverController;

- (instancetype)initWithImageURLString:(NSString *)imageURLString;
//  marsRoverController:(MarsRoverController *)marsRoverController;

@end

NS_ASSUME_NONNULL_END
