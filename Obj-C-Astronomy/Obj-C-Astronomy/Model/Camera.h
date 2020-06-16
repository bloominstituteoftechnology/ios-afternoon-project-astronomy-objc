//
//  Camera.h
//  Obj-C-Astronomy
//
//  Created by Patrick Millet on 6/16/20.
//  Copyright © 2020 PatrickMillet79. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Camera : NSObject

@property (nonatomic, readonly) int identifier;
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly) int roverID;
@property (nonatomic, readonly, copy) NSString *fullName;

- (instancetype)initWithIdentifier:(int)identifier
                              name:(NSString *)name
                           roverID:(int)roverID
                          fullName:(NSString *)fullName;

@end

NS_ASSUME_NONNULL_END
