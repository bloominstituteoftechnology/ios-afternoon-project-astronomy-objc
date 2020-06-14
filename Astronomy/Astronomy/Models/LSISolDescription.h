//
//  LSISolDescription.h
//  Astronomy
//
//  Created by David Wright on 6/3/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(SolDescription)
@interface LSISolDescription : NSObject

@property (nonatomic, readonly) int sol;
@property (nonatomic, readonly) int totalPhotos;
@property (nonatomic, copy, readonly, nonnull) NSArray<NSString *> *cameras;

// Unused API values
/*
@property (nonatomic, readonly, nonnull) NSDate *earthDate;
*/

- (nonnull instancetype)initWithSol:(int)sol
                        totalPhotos:(int)totalPhotos
                            cameras:(nonnull NSArray<NSString *> *)cameras;

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end
