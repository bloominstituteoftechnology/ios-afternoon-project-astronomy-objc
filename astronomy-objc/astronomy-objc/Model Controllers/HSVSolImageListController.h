//
//  HSVSolImageListController.h
//  astronomy-objc
//
//  Created by Hector Steven on 7/23/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_SWIFT_NAME(SolImageListController)

@interface HSVSolImageListController : NSObject

- (void)fetchImageListWithSol:(int)sol Completion:(void (^)(NSError *error ))completion;

- (NSArray *)solImageList;

- (void)Test;

@end


