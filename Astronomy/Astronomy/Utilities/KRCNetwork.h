//
//  KRCNetwork.h
//  Astronomy
//
//  Created by Christopher Aronson on 7/22/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^KRCNetworkCompletion)(NSDictionary * _Nullable, NSError * _Nullable);
typedef void (^KRCNetworkImageCompletion)(NSData * _Nullable, NSError * _Nullable);

@interface KRCNetwork : NSObject

- (void)networkCallForURL:(NSURL  * _Nonnull)url completion:(KRCNetworkCompletion _Nonnull)completion;

- (void)networkCallForImage:(NSURL * _Nonnull)url completion:(KRCNetworkImageCompletion _Nonnull)completion;
@end
