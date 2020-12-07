//
//  CMBMarsSolDictionary.h
//  Astronomy
//
//  Created by Craig Belinfante on 12/6/20.
//

#import <Foundation/Foundation.h>

@class CMBMarsSol;

NS_SWIFT_NAME(SolDictionary)
@interface CMBMarsSolDictionary : NSObject

@property (nonatomic, readonly, copy) NSArray<CMBMarsSol *> *sols;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
