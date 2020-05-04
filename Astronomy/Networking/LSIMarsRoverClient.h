//
//  LSIMarsRoverClient.h
//  Astronomy
//
//  Created by Andrew R Madsen on 10/8/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSIMarsRover;
@class LSIMarsPhoto;

@interface LSIMarsRoverClient : NSObject

- (void)fetchAllMarsRoversWithCompletion:(void(^)(NSArray<NSString *> *roverNames, NSError *error))completion;
- (void)fetchMissionManifestForRoverNamed:(NSString *)name completion:(void(^)(LSIMarsRover *rover, NSError *error))completion;
- (void)fetchPhotosFromRover:(LSIMarsRover *)rover onSol:(NSInteger)sol completion:(void(^)(NSArray<LSIMarsPhoto *> *photos, NSError *error))completion;
- (void)fetchImageDataForPhoto:(LSIMarsPhoto *)photo completion:(void(^)(NSData *imageData, NSError *error))completion;

@end
