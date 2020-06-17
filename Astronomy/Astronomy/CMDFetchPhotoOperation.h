//
//  CMDFetchPhotoOperation.h
//  Astronomy
//
//  Created by Chris Dobek on 6/17/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMDFetchPhotoOperation : NSObject

@property (nonatomic, nullable) NSData *imgData;

- (instancetype)initWithImageURLString:(NSString *)imageURLString;

@end

NS_ASSUME_NONNULL_END
