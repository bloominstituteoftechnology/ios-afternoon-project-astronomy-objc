//
//  VVSSolDescription.h
//  Astronomy-Hybrid
//
//  Created by Vici Shaweddy on 2/13/20.
//  Copyright © 2020 Vici Shaweddy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(SolDescription)
@interface VVSSolDescription : NSObject

@property (nonatomic, readonly) NSInteger sol;
@property (nonatomic, readonly) NSInteger totalPhotos;
@property (nonatomic, readonly) NSArray *cameras;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
