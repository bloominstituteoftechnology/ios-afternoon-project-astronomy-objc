//
//  NSURL+SecureHTTP.h
//  Astronomy-ObSwiftive-c
//
//  Created by Craig Swanson on 4/22/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (SecureHTTP)

+ (NSURL *)convertHTTPtoHTTPS:(NSURL *)inputURL;

@end

NS_ASSUME_NONNULL_END
