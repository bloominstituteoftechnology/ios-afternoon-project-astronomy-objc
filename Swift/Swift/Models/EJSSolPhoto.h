//
//  EJSSolPhoto.h
//  Swift
//
//  Created by Enzo Jimenez-Soto on 7/21/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EJSSolPhoto : NSObject

@property (nonatomic) NSNumber *solId;
@property (nonatomic) NSString *imageUrl;
@property (nonatomic) NSDate *earthDate;

-(instancetype)initWithSolid:(NSNumber *)solId imageUrl:(NSString *)imageUrl earthDate:(NSDate *)earthDate;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
