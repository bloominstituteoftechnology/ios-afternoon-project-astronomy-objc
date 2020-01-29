//
//  SKSFetchPhotoOperation.h
//  Astronomy-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKSPhotoReference;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(FetchPhotoOperation)

@interface SKSFetchPhotoOperation : NSOperation

@property (nonatomic, nullable) NSData *imageData;

- (instancetype)initWithPhotoReference:(SKSPhotoReference *)photoReference;

@end

NS_ASSUME_NONNULL_END

