//
//  SAHFetchPhotoOperation.h
//  Astronomy-ObjC
//
//  Created by scott harris on 4/21/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SAHSolPhoto;

NS_ASSUME_NONNULL_BEGIN

@interface SAHFetchPhotoOperation : NSOperation

@property (nonatomic, readonly) SAHSolPhoto *solPhoto;
@property (nonatomic) NSData *imageData;

-(instancetype)initWithSolPhoto:(SAHSolPhoto *)photo;

@end

NS_ASSUME_NONNULL_END
