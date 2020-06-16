//
//  KMLManifest.h
//  Astronomy_ObjectiveC
//
//  Created by Mark Poggi on 6/15/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KMLSol;

NS_ASSUME_NONNULL_BEGIN

@interface KMLManifest : NSObject

@property (copy, nonatomic) NSString *roverName;
///used to hold sol IDs in order to download sols
@property (nonatomic, copy) NSArray *solIDs;
///Actual Sol Objects downloaded using solIDs
@property (nonatomic, copy) NSMutableArray *sols;

- (instancetype)initWithRoverName:(NSString *)roverName solIDs:(NSArray *)sols;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(void)addSol:(KMLSol *)sol;

@end

NS_ASSUME_NONNULL_END
