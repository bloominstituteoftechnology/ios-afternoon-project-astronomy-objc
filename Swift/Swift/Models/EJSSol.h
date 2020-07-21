//
//  EJSSol.h
//  Swift
//
//  Created by Enzo Jimenez-Soto on 7/21/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EJSSol : NSObject
@property (nonatomic) int identifier;
@property (nonatomic) NSDate *earthDate;
@property (nonatomic) int totalPhotos;

- (instancetype)initWithIdentifier:(int)identifier earthDate:(NSDate *)earthDate totalPhotos:(int)totalPhotos;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
