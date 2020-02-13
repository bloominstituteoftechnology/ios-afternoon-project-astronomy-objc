//
//  Camera.h
//  Astronomy-ObjC
//
//  Created by John Kouris on 2/12/20.
//  Copyright © 2020 John Kouris. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Camera : NSObject

@property (nonatomic, readonly) int id;
@property (nonatomic, copy, readonly, nonnull) NSString *name;
@property (nonatomic, readonly) int roverId;
@property (nonatomic, copy, readonly, nonnull) NSString *fullName;

@end

NS_ASSUME_NONNULL_END
