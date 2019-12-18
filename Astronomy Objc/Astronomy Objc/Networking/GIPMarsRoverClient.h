//
//  GIPMarsRoverClient.h
//  Astronomy Objc
//
//  Created by Gi Pyo Kim on 12/17/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GIPMarsRover;
@class MarsPhoto;

NS_SWIFT_NAME(MarsRoverClient)
@interface GIPMarsRoverClient : NSObject

- (void)fetchRover:(NSString *)rover completion:(void (^)(GIPMarsRover *rover, NSError *error))completion;
- (void)fetchPhoto:(NSString *)rover sol:(int)sol completion:(void (^)(NSArray<MarsPhoto *> *photos, NSError *error))completion;


@end

