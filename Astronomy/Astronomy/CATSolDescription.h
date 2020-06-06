//
//  CATSolDescription.h
//  Astronomy
//
//  Created by Jessie Ann Griffin on 6/3/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(SolDescription)
@interface CATSolDescription : NSObject

@property (nonatomic, readonly) int sol;
@property (nonatomic, readonly) int totalPhotos;
@property (nonatomic, readonly, copy) NSArray<NSString *> *cameras;

- (instancetype)initWithSol:(int)aSol
                totalPhotos:(int)totalPhotosCount
                    cameras:(NSArray<NSString *> *)allCameras;

@end

NS_ASSUME_NONNULL_END
