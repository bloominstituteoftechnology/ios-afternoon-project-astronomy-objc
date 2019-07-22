//
//  KRCNetwork.h
//  Astronomy
//
//  Created by Christopher Aronson on 7/22/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^KRCNetworkCompletion)(NSDictionary * _Nullable, NSError * _Nullable);

NS_ASSUME_NONNULL_BEGIN

@interface KRCNetwork : NSObject

- (void)NetworkCallForURL:(NSURL *)url completion: (KRCNetworkCompletion)completion;

@end

NS_ASSUME_NONNULL_END
