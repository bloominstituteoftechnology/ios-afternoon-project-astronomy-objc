//
//  KRCPhotoInfo.h
//  Astronomy
//
//  Created by Christopher Aronson on 7/23/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KRCPhotoInfo : NSObject

@property (nonatomic, nonnull, readonly) NSURL *photoURL;

- (instancetype _Nonnull)initWithURL:(NSURL * _Nonnull)url;

@end
