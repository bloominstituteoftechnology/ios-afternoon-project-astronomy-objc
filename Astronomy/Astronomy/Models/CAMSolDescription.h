//
//  CAMSolDescription.h
//  Astronomy
//
//  Created by Cody Morley on 7/20/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(SolDescription)

@interface CAMSolDescription : NSObject

@property (nonatomic, readonly) int sol;
@property (nonatomic, readonly) int totalPhotos;
@property (nonatomic, readonly, copy) NSArray <NSString *> *cameras;

- (instancetype)initWithSol:(int)sol
                totalPhotos:(int)totalPhotos
                    cameras:(NSArray <NSString *> *)cameras;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

NS_ASSUME_NONNULL_END
@end


