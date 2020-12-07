//
//  CMBMarsController.h
//  Astronomy
//
//  Created by Craig Belinfante on 12/6/20.
//

#import <Foundation/Foundation.h>

@class CMBMarsSolDictionary;
@class CMBMarsSol;
@class CMBMarsObject;

typedef void (^FetchSolCompletion)(CMBMarsSolDictionary * _Nullable dictionary, NSError * _Nullable error);
typedef void (^FetchPhotosCompletion)(NSArray<CMBMarsObject *> * _Nullable photos, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(MarsClient)
@interface CMBMarsController : NSObject

- (void)fetchDetailsForRoverNamed:(NSString *)roverName
                        completion:(FetchSolCompletion)completion;
- (void)fetchPhotosForRoverNamed:(NSString *)roverName
                           onSol:(CMBMarsSol *)sol
                      completion:(FetchPhotosCompletion)completion;
@end

NS_ASSUME_NONNULL_END
