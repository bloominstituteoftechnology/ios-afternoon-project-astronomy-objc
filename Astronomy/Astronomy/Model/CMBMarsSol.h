//
//  CMBMarsSol.h
//  Astronomy
//
//  Created by Craig Belinfante on 12/6/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMBMarsSol : NSObject

@property (nonatomic, readonly) int solNumber;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
