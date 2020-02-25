//
//  CARMarsCamera.h
//  CARAstronomy
//
//  Created by Chad Rutherford on 2/24/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CARMarsCamera : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *fullName;

- (instancetype) initWithName:(NSString *)name
                     fullName:(NSString *)fullName;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
