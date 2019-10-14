//
//  REPRoverControllerDelegate.h
//  Astronomy Combo
//
//  Created by Michael Redig on 10/14/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@class REPRoverController;
@protocol REPRoverControllerDelegate <NSObject>

- (void)roverControllerLoadedData:(REPRoverController *_Nonnull)controller;

@end
