//
//  Camera.h
//  AstronomyInteroperability
//
//  Created by Nonye on 7/20/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(Camera)

@interface NNECamera : NSObject

@property (nonatomic, readonly) int cameraID;
@property (nonatomic, readonly) int roverID;
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *fullName;

-(instancetype)initWithID:(int)cameraID
                        roverID:(int)roverID
                           name:(NSString *)name
                       fullName:(NSString *)fullName;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
