//
//  MarsRoverClient.h
//  AstronomyObjC
//
//  Created by morse on 1/26/20.
//  Copyright © 2020 morse. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DMORover;
@class DMOSolDescription;
@class DMOPhotoReference;

NS_SWIFT_NAME(MarsRoverClient)

@interface DMOMarsRoverClient : NSObject

- (void) fetchMarsRoverWithName:(NSString *)name completion:(void (^)(DMORover *rover, NSError *error))completion;
- (void) fetchPhotosFromRover:(DMORover *)rover onSol:(int)sol completion:(void (^)(NSArray<DMOPhotoReference *> *photoRefs, NSError *error))completion;

@end
