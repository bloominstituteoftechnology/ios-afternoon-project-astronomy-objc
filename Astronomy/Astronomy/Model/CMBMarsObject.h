//
//  CMBMarsObject.h
//  Astronomy
//
//  Created by Craig Belinfante on 12/6/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMBMarsObject : NSObject

@property (nonatomic, readonly) int solNumber;
@property (nonatomic, readonly) NSURL *imageURL;
@property (nonatomic, readonly) int roverID;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
