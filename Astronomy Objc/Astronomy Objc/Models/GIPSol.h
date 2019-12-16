//
//  GIPSol.h
//  Astronomy Objc
//
//  Created by Gi Pyo Kim on 12/16/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GIPSol : NSObject

@property (nonatomic, readonly) int sol;
@property (nonatomic, readonly, copy, nonnull) NSString *earthDate;
@property (nonatomic, readonly) int totalPhotos;

- (nonnull instancetype)initWithSol:(int)sol earthDate:(nonnull NSString *)earthDate totalPhotos:(int)totalPhotos;
- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end
