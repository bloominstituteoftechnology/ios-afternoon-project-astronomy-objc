//
//  Camera.h
//  Astronomy-Hybrid
//
//  Created by Bobby Keffury on 2/12/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Camera : NSObject

@property (nonatomic) NSInteger *id;
@property (nonatomic) NSString *name;
@property (nonatomic) NSInteger *roverId;
@property (nonatomic) NSString *fullName;

@end

NS_ASSUME_NONNULL_END
