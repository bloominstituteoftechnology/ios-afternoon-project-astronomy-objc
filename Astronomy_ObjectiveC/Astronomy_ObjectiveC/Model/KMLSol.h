//
//  KMLSol.h
//  Astronomy_ObjectiveC
//
//  Created by Kenny on 6/15/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KMLSol : NSObject

@property (nonatomic) int solID;
@property (nonatomic) NSArray *photoURLs;

- (instancetype) initWithSolID:(int)solID photoURLs:(NSArray *)photoURLs;

@end

NS_ASSUME_NONNULL_END
