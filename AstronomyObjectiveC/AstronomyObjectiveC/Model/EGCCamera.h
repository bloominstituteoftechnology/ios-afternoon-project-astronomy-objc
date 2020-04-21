//
//  EGCCamera.h
//  AstronomyObjectiveC
//
//  Created by Enrique Gongora on 4/21/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(Camera)
@interface EGCCamera : NSObject

- (instancetype)initWithIdentifier:(NSInteger)identifier name:(NSString *)name roverId:(NSInteger)roverId fullName:(NSString *)fullName;

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly) NSInteger identifier;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSInteger roverId;
@property (nonatomic, readonly) NSString *fullName;


@end

NS_ASSUME_NONNULL_END
