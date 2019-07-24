//
//  KRCPhotoInfo.h
//  Astronomy
//
//  Created by Christopher Aronson on 7/23/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(PhotoInfo)
@interface KRCPhotoInfo : NSObject

@property (nonatomic, nonnull, readonly) NSString *photoURL;

- (instancetype _Nonnull)initWithURL:(NSString * _Nonnull)url;

@end
