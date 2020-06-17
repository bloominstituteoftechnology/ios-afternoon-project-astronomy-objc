//
//  KMLRoverController.h
//  Astronomy_ObjectiveC
//
//  Created by Kenny on 6/15/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KMLManifest;
@class KMLSol;

NS_ASSUME_NONNULL_BEGIN


@interface KMLRoverController : NSObject

@property (nonatomic, copy, readonly) KMLManifest *manifest;

- (void)fetchSolsFromRoverWithName:(NSString *)name completion:(void (^)(KMLManifest *))completion;

- (void)fetchPhotosWithRoverName:(NSString *)name OnSol:(NSNumber *)sol completion:(void (^)(KMLSol *))completion;


@end

NS_ASSUME_NONNULL_END
