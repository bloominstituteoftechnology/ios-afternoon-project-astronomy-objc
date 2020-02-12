//
//  SolDescription.h
//  Astronomy-Hybrid
//
//  Created by Bobby Keffury on 2/12/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SolDescription : NSObject

@property (nonatomic) NSInteger *sol;
@property (nonatomic) NSInteger *totalPhotos;
@property (nonatomic) NSArray<NSString *> *cameras;

@end

NS_ASSUME_NONNULL_END
