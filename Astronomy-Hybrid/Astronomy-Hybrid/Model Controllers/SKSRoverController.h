//
//  SKSRoverController.h
//  Astronomy-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKSRoverController : NSObject

- (void)photoManifestForRover:(void (^)(NSError *error))completion;
- (void)photosForRoverOnSol:(NSString *)sol completion:(void (^)(NSError *error))completion;

@end

