//
//  SolDescription.m
//  Astronomy
//
//  Created by Cora Jacobson on 12/5/20.
//

#import "SolDescription.h"

@implementation SolDescription

- (nonnull instancetype)initWithSol:(int)aSol totalPhotos:(int)aTotal cameras:(NSArray<NSString *> *)someCameras
{
    if (self = [super init]) {
        _sol = aSol;
        _totalPhotos = aTotal;
        _cameras = someCameras.copy;
    }
    return self;
}

- (nullable instancetype)initWithDictionary:(NSDictionary *)aDictionary
{
    NSNumber *sol = [aDictionary objectForKey:@"sol"];
    if (![sol isKindOfClass:NSNumber.class]) return nil;
    
    NSNumber *totalPhotos = [aDictionary objectForKey:@"total_photos"];
    if (![totalPhotos isKindOfClass:NSNumber.class]) return nil;
    
    NSArray<NSString *> *cameras = [aDictionary objectForKey:@"cameras"];
    if (![cameras isKindOfClass:NSArray.class]) return nil;
    
    return [self initWithSol:sol.intValue
                 totalPhotos:totalPhotos.intValue
                     cameras:cameras];
}

@end
