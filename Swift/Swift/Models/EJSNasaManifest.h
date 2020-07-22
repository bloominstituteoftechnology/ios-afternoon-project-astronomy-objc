//
//  EJSNasaManifest.h
//  Swift
//
//  Created by Enzo Jimenez-Soto on 7/21/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

#import <Foundation/Foundation.h>


@class EJSSol;

@interface EJSNasaManifest : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic) int maxSol;
@property (nonatomic) NSArray<EJSSol *> *sols;

- (instancetype)initWithName:(NSString *)name maxSol:(int)maxSol sols:(NSArray<EJSSol *> *)sols;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

