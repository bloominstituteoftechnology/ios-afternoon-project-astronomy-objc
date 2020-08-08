//
//  SolDescription.h
//  Astronomy-ObjC
//
//  Created by Chad Parker on 8/6/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SolDescription : NSObject

@property (nonatomic) int sol;
@property (nonatomic) int totalPhotos;
@property (nonatomic, copy) NSArray<NSString *> *cameras;

@end

NS_ASSUME_NONNULL_END
