//
//  SSSCodableObject.h
//  FavoriteArtists
//
//  Created by Shawn Gee on 5/18/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef CODING_KEY
    #define CODING_KEY(prop) NSStringFromSelector(@selector(prop))
#endif

NS_ASSUME_NONNULL_BEGIN

@interface SSSCodableObject : NSObject

@property (nonatomic, readonly) NSDictionary *codingKeys;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)toDictionary;

@end

NS_ASSUME_NONNULL_END
