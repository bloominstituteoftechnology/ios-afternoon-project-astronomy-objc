//
//  HSVSolController.h
//  astronomy-objc
//
//  Created by Hector Steven on 7/22/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HSVSolPhoto;

NS_SWIFT_NAME(SolController)


@interface HSVSolController : NSObject


- (void)fetchSolsWithCompletion:(void (^)(NSError *error ))completion;

- (void)fetchImageListWithSol:(int)sol Completion:(void (^)(NSArray <HSVSolPhoto *> *imageList, NSError *error))completion;

- (NSArray *)Sols;



@end


