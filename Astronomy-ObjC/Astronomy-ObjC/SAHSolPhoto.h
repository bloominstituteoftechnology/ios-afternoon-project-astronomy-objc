//
//  SAHSolPhoto.h
//  Astronomy-ObjC
//
//  Created by scott harris on 4/20/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAHSolPhoto : NSObject

@property (nonatomic) NSNumber *solId;
@property (nonatomic) NSString *imageUrl;
@property (nonatomic) NSDate *earthDate;

-(instancetype)initWithSolid:(NSNumber *)solId imageUrl:(NSString *)imageUrl earthDate:(NSDate *)earthDate;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
