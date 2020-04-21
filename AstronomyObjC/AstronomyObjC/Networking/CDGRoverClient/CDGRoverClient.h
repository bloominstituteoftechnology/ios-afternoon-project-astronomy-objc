//
//  CDGRoverClient.h
//  AstronomyObjC
//
//  Created by Chris Gonzales on 4/21/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CDGRover;
@class CDGPhoto;

@interface CDGRoverClient : NSObject

- (void)fetchAllMarsRoversWithCompletion:(void(^)(NSArray<NSString *> *roverNames, NSError *error))completion;

- (void)fetchMissionManifestForRover:(NSString *)name completion:(void(^)(CDGRover *rover, NSError *error))completion;

- (void)fetchPhotosFromRover:(CDGRover *)rover onSol:(NSInteger)sol completion:(void(^)(NSArray<CDGPhoto *> *photos, NSError *error))completion;

- (void)fetchImageDataForPhoto:(CDGPhoto *)photo completion:(void(^)(NSData *imageData, NSError *error))completion;

@end
