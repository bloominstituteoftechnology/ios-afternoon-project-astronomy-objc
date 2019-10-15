//
//  BYSolDescription.h
//  Astronomy-objc
//
//  Created by Bradley Yin on 10/14/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYSolDescription : NSObject

@property (nonnull) NSNumber *sol;
@property (nonnull) NSNumber *totalPhotos;
@property (nonnull) NSArray<NSString *> *cameras;

- (instancetype)initWithDictionary:(NSDictionary *_Nonnull)dictionary;

@end


