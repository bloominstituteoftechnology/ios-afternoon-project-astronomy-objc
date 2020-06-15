//
//  KMLManifest.h
//  Astronomy_ObjectiveC
//
//  Created by Mark Poggi on 6/15/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KMLManifest : NSObject

@property (copy, nonatomic) NSString *roverName;
@property (nonatomic) int photoId;
@property (nonatomic) NSArray *sols;

- (instancetype)initWithRoverName: (NSString *)roverName sols:(NSArray *)sols;
- (instancetype)initWithDictionary: (NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
