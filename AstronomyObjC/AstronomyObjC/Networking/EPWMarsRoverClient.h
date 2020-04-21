//
//  EPWMarsRoverClient.h
//  AstronomyObjC
//
//  Created by Elizabeth Wingate on 4/20/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class EPWMarsRover;
@class EPWMarsPhoto;

@interface EPWMarsRoverClient : NSObject

- (void)fetchAllMarsRoversWithCompletion:(void(^)(NSArray<NSString *> *roverNames, NSError *error))completion;
- (void)fetchMissionManifestForRoverNamed:(NSString *)name completion:(void(^)(EPWMarsRover *rover, NSError *error))completion;
- (void)fetchPhotosFromRover:(EPWMarsRover *)rover onSol:(NSInteger)sol completion:(void(^)(NSArray<EPWMarsPhoto *> *photos, NSError *error))completion;
- (void)fetchImageDataForPhoto:(EPWMarsPhoto *)photo completion:(void(^)(NSData *imageData, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
