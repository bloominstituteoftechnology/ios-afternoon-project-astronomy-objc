//
//  SolPhoto.h
//  Astronomy-ObSwiftive-c
//
//  Created by Craig Swanson on 4/20/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SolPhoto : NSObject

// sol
// total_photos
@property (nonatomic, readonly) int sol;
@property (nonatomic, readonly) int total_photos;
@property (nonatomic, readonly) NSArray<SolPhoto *> *solPhotos;

- (instancetype)initWithSol:(int)sol
                totalPhotos:(int)total_photos;

- (instancetype)initWithSols:(NSArray<SolPhoto *> *)solPhotos;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
