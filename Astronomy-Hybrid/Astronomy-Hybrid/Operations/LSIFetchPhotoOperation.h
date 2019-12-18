//
//  LSIFetchPhotoOperation.h
//  Astronomy-Hybrid
//
//  Created by Isaac Lyons on 12/17/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MarsPhotoReference;

NS_SWIFT_NAME(FetchPhotoOperation)
@interface LSIFetchPhotoOperation : NSOperation

@property (nonatomic, copy, readonly, nullable) NSData* imageData;

- (nonnull instancetype)initWithPhotoReference:(MarsPhotoReference *_Nonnull)photoReference;

@end
