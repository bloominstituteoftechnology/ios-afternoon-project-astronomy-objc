//
//  TLManifest.h
//  Astronomy-Interoperability
//
//  Created by Christian Lorenzo on 6/3/20.
//  Copyright © 2020 Christian Lorenzo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Manifest)
@interface TLManifest : NSObject

@property (nonatomic, readonly) int solID;
@property (nonatomic, readonly) int photoCount;
@property (nonatomic, readonly, copy) NSArray<NSString *> *cameras;

- (instancetype)initWithSolID:(int)solID photoCount:(int)photoCount cameras:(NSArray<NSString *> *)cameras;

@end

NS_ASSUME_NONNULL_END
