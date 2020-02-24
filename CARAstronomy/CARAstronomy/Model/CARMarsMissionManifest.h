//
//  CARMarsMissionManifest.h
//  CARAstronomy
//
//  Created by Chad Rutherford on 2/24/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CARMarsMissionManifest : NSObject

@property (nonatomic, readonly, nonnull) NSArray *sols;

- (instancetype _Nonnull) initWitihDictionary:(NSDictionary *_Nonnull)dictionary;

@end
