//
//  NPTSolController.h
//  AstronomyObjC
//
//  Created by Nick Nguyen on 4/21/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Sol;
NS_SWIFT_NAME(SolController)

@interface NPTSolController : NSObject

@property (nonatomic, readonly, copy, nonnull) Sol *sol;


- (instancetype _Nullable )initWithDictionary:(NSDictionary *_Nullable)dictionary;





@end

