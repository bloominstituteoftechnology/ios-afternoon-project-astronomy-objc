//
//  FetchPhotoOperation.h
//  AstronomyInteroperability
//
//  Created by Nonye on 7/21/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FetchPhotoOperation : NSObject

@property (nonatomic, nullable) NSData *imgData;

- (instancetype)initWithImageURLString:(NSString *)imageURLString;

@end

NS_ASSUME_NONNULL_END
