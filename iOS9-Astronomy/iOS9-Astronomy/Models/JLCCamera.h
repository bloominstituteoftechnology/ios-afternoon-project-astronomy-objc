//
//  JLCCamera.h
//  iOS9-Astronomy
//
//  Created by Jake Connerly on 11/12/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JLCCamera : NSObject
    
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *fullName;

- (instancetype)initWithName:(NSString *)name
                    fullName:(NSString *)fullName;

- (nullable instancetype)initWithDictionary:(NSDictionary *)cameraDictionary;

@end

NS_ASSUME_NONNULL_END
