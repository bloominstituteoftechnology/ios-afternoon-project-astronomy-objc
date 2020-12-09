//
//  MarsRoverClient.h
//  Astronomy
//
//  Created by Cora Jacobson on 12/9/20.
//

#import <Foundation/Foundation.h>

@class MarsRover;
@class SolDescription;
@class MarsPhoto;
@class Camera;

typedef void (^RoverCompletionHandler)(MarsRover *_Nullable rover, NSError *_Nullable error);
typedef void (^PhotosCompletionHandler)(NSArray<MarsPhoto *> *_Nullable photos, NSError *_Nullable error);

@interface MarsRoverClient : NSObject

+ (void)fetchMarsRoverWithName:(NSString *_Nonnull)aName
             completionHandler:(nonnull RoverCompletionHandler)completionHandler;

+ (void)fetchPhotosFromRover:(NSString *_Nonnull)aName
                         Sol:(int)onSol
           completionHandler:(PhotosCompletionHandler _Nonnull )completionHandler;

+ (NSURL *_Nonnull)urlForInfoWithRover:(NSString *_Nonnull)roverName;
+ (NSURL *_Nonnull)urlForPhotosFromRover:(NSString *_Nonnull)roverName sol:(int)onSol;

@end
