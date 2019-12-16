//
//  JLRSolDescription.h
//  Astronomy
//
//  Created by Jesse Ruiz on 12/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_SWIFT_NAME(SolDescription)
@interface JLRSolDescription : NSObject
//TODO: Make it Codable & Equatable

@property (nonatomic, copy, readonly, nonnull) NSArray<NSString *> *cameras;
@property (nonatomic, readonly) double sol;
@property (nonatomic, readonly) double totalPhotos;

- (nonnull instancetype)initWithCamera:(nonnull NSArray<NSString *> *)cameras
                                   sol:(double)sol
                           totalPhotos:(double)totalPhotos;

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)solDescriptionDictionary;
@end
