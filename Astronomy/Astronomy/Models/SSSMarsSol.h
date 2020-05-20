//
//  SSSMarsSol.h
//  Astronomy
//
//  Created by Shawn Gee on 5/18/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(MarsSol)
@interface SSSMarsSol : NSObject

@property (nonatomic, readonly) int solNumber;
@property (nonatomic, readonly) int numPhotos;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
