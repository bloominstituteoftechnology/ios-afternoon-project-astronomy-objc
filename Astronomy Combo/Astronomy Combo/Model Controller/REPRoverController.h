//
//  REPRoverController.h
//  Astronomy Combo
//
//  Created by Michael Redig on 10/14/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REPRoverControllerDelegate.h"

NS_SWIFT_NAME(RoverController)
@interface REPRoverController : NSObject

typedef void (^REPNetworkCompletionBlock)(NSError *_Nullable);

@property (nonatomic, readonly, nonnull) NSArray<NSURL *> *currentSolPhotos;
@property (nonatomic, nullable) NSString *currentRover;
@property (nonatomic, readonly) NSUInteger currentSolIndex;
@property (weak, nullable) id <REPRoverControllerDelegate> delegate;

- (instancetype _Nonnull)initWithRoverNamed:(NSString *_Nonnull)name;
- (void)nextSol;
- (void)previousSol;

@end
