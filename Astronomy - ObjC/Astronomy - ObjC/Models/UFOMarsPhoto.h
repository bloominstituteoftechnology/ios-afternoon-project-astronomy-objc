//
//  UFOMarsPhoto.h
//  Astronomy - ObjC
//
//  Created by Ufuk Türközü on 20.04.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UFOCamera;

@interface UFOMarsPhoto : NSObject

@property (nonatomic, readonly)int identfier;
@property (nonatomic, readonly)int sol;
@property (nonatomic, readonly)UFOCamera *camera;
@property (nonatomic, readonly)NSURL *imgSrc;
@property (nonatomic, readonly)NSDate *earthDate;

- (instancetype) initWithIdentifier:(int) identifier
                                sol:(int)sol
                             camera:(UFOCamera *)camera
                             imgSrc:(NSURL *)imgSrc
                          earthDate:(NSDate *)earthDate;

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
