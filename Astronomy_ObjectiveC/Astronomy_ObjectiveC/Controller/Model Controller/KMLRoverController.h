//
//  KMLRoverController.h
//  Astronomy_ObjectiveC
//
//  Created by Kenny on 6/15/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KMLManifest;

NS_ASSUME_NONNULL_BEGIN

@interface KMLRoverController : NSObject

- (void)fetchSolsFromRoverWithName:(NSString *)name completion:(void (^)(KMLManifest *))completion;

- (void)fetchPhotosOnSol:(int)sol;


@end

NS_ASSUME_NONNULL_END
