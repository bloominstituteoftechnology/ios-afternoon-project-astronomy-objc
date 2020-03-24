//
//  MBMPhoto.h
//  Astronomy-Objc
//
//  Created by Michael on 3/23/20.
//  Copyright © 2020 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MBMCamera;

@interface MBMPhoto : NSObject

@property (nonatomic, readonly)int identifier;
@property (nonatomic, readonly)int sol;
@property (nonatomic, readonly)MBMCamera *camera; // TODO: - Change this type from string to Camera later
@property (nonatomic, readonly)NSString *imgSrc;
@property (nonatomic, readonly)NSDate *earthDate;

-(instancetype)initWithIdentifier:(int)identifier
                              sol:(int)sol
                           camera:(MBMCamera *)camera
                           imgSrc:(NSString *)imgSrc
                        earthDate:(NSDate *)earthDate;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
