//
//  SolCamera.h
//  AstronomyObjC
//
//  Created by Nick Nguyen on 4/21/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SolCamera : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *fullName;

- (instancetype)initWithName:(NSString *)name
                    fullName:(NSString *)fullName;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END
