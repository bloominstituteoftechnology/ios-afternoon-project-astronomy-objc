//
//  SAHSol.h
//  Astronomy-ObjC
//
//  Created by scott harris on 4/20/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SAHSol : NSObject

@property (nonatomic) int identifier;
@property (nonatomic) NSDate *earthDate;
@property (nonatomic) int totalPhotos;

- (instancetype)initWithIdentifier:(int)identifier earthDate:(NSDate *)earthDate totalPhotos:(int)totalPhotos;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

