//
//  HAOManifest.h
//  Astronomy-ObjcSwift
//
//  Created by Hunter Oppel on 6/16/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(Manifest)

@interface HAOManifest : NSObject

@property NSArray<NSNumber *> *solManifest;

- (instancetype)initWithSolManifest:(NSArray<NSNumber *> *)solManifest;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
