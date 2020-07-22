//
//  EJSFetchPhotoOperation.h
//  Swift
//
//  Created by Enzo Jimenez-Soto on 7/21/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EJSSolPhoto;

NS_ASSUME_NONNULL_BEGIN

@interface EJSFetchPhotoOperation : NSOperation

@property (nonatomic, readonly) EJSSolPhoto *solPhoto;
@property (nonatomic) NSData *imageData;

-(instancetype)initWithSolPhoto:(EJSSolPhoto *)photo;

@end

NS_ASSUME_NONNULL_END
