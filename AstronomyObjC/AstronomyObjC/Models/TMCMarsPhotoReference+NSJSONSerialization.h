//
//  TMCMarsPhotoReference+NSJSONSerialization.h
//  AstronomyObjC
//
//  Created by Christopher Devito on 5/18/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import "TMCMarsPhotoReference.h"

NS_ASSUME_NONNULL_BEGIN

@interface TMCMarsPhotoReference (NSJSONSerialization)

- (instancetype) initWithMarsPhotoDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
