//
//  LSIMarsRover.m
//  Astronomy
//
//  Created by David Wright on 6/3/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

#import "LSIMarsRover.h"

@implementation LSIMarsRover

- (instancetype)initWithName:(NSString *)name
              numberOfPhotos:(int)numberOfPhotos
                      maxSol:(int)maxSol
             solDescriptions:(NSArray<NSDictionary *> *)solDescriptions
{
    if (self = [super init]) {
        _name = name.copy;
        _numberOfPhotos = numberOfPhotos;
        _maxSol = maxSol;
        _solDescriptions = solDescriptions.copy;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = [dictionary objectForKey:@"name"];
    if (![name isKindOfClass:[NSString class]]) return nil;
    
    NSNumber *numberOfPhotos = [dictionary objectForKey:@"total_photos"];
    if (![numberOfPhotos isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *maxSol = [dictionary objectForKey:@"max_sol"];
    if (![maxSol isKindOfClass:[NSNumber class]]) return nil;
    
    NSArray *solDescriptions = [dictionary objectForKey:@"photos"];
    if (![solDescriptions isKindOfClass:[NSArray class]]) return nil;
    
    return [self initWithName:name
               numberOfPhotos:numberOfPhotos.intValue
                       maxSol:maxSol.intValue
              solDescriptions:solDescriptions];
}

@end
