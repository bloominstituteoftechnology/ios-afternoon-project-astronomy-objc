//
//  TXCSol.h
//  AstronomyObjc
//
//  Created by Thomas Cacciatore on 7/23/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TXCSol : NSObject

@property int solNumber;
@property int totalPhotos;
//@property NSArray *cameras; //Array of Strings

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
