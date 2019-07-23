//
//  HSVSolController.h
//  astronomy-objc
//
//  Created by Hector Steven on 7/22/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "astronomy_objc-Swift.h"

NS_SWIFT_NAME(SolController)
//NS_ASSUME_NONNULL_BEGIN

@interface HSVSolController : NSObject

- (void)fetchSolsWithCompletion:(void (^)(NSError *))completion;

@end
//NS_ASSUME_NONNULL_END

