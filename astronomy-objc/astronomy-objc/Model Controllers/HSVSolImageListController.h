//
//  HSVSolImageListController.h
//  astronomy-objc
//
//  Created by Hector Steven on 7/23/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HSVSolPhoto;
NS_SWIFT_NAME(SolImageListController)

@interface HSVSolImageListController : NSObject

//- (void)fetchImageListWithSol:(int)sol Completion:(void (^)(NSArray<HSVSolPhoto *> *, NSError *error ))completion;
//- (void)fetchImageListWithSol:(int)sol Completion:(void (^)(NSArray<HSVSolPhoto *> *, NSError *error ))completion;

- (NSArray *)solImageList;

- (void)Test;

@end


