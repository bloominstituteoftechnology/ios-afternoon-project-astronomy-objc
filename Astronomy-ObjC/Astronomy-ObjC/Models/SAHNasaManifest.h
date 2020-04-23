//
//  SAHNasaManifest.h
//  Astronomy-ObjC
//
//  Created by scott harris on 4/20/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SAHSol;

@interface SAHNasaManifest : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic) int maxSol;
@property (nonatomic) NSArray<SAHSol *> *sols;

- (instancetype)initWithName:(NSString *)name maxSol:(int)maxSol sols:(NSArray<SAHSol *> *)sols;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
