//
//  CARMarsSol.h
//  CARAstronomy
//
//  Created by Chad Rutherford on 2/24/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CARMarsCamera.h"

NS_ASSUME_NONNULL_BEGIN

@interface CARMarsSol : NSObject

@property (nonatomic, readonly) NSNumber *idNumber;
@property (nonatomic, readonly) NSNumber *sol;
@property (nonatomic, readonly, copy) NSString *imageURL;
@property (nonatomic, readonly) CARMarsCamera *camera;
@property (nonatomic, readonly) NSDate *earthDate;


- (instancetype) initWithIdNumber:(NSNumber *)idNumber
                              sol:(NSNumber *)sol
                         imageURL:(NSString *)imageURL
                           camera:(CARMarsCamera *)camera
                        earthDate:(NSDate *)earthDate;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
