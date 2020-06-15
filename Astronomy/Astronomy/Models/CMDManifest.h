//
//  CMDManifest.h
//  Astronomy
//
//  Created by Chris Dobek on 6/15/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMDManifest : NSObject

@property (nonatomic, readonly) int solID;
@property (nonatomic, readonly) int photoCount;
@property (nonatomic, readonly) NSArray<NSString *> *cameras;

-(instancetype)initWithSolID:(int)solID photoCount:(int)photoCount cameras:(NSArray<NSString *> *)cameras;

@end

NS_ASSUME_NONNULL_END
