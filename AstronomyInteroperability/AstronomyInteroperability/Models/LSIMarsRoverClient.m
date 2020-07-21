//
//  LSIMarsRoverClient.m
//  AstronomyInteroperability
//
//  Created by Nonye on 7/20/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

#import "LSIMarsRoverClient.h"

@implementation LSIMarsRoverClient

- (instancetype)initWithID:(int)roverID
                      name:(NSString *)name
                launchDate:(NSString *)launchDate
               landingDate:(NSString *)landingDate
                    status:(NSString *)status
                    maxSol:(int)maxSol
                   maxDate:(NSString *)maxDate
            numberOfPhotos:(int)numberOfPhotos
                      sols:(NSArray *)sols
{
    if (self = [super init]) {
        _name = name;
        _landingDate = landingDate;
           _launchDate = launchDate;
           _status = status;
           _maxSol = maxSol;
           _maxDate = maxDate;
           _numberOfPhotos = numberOfPhotos;
           _sols = sols;
       }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary

{
    NSString *name = [dictionary objectForKey:@"name"];
    NSString *landingDate = [dictionary objectForKey:@"landing_date"];
    NSString *launchDate = [dictionary objectForKey:@"launch_date"];
    NSString *status = [dictionary objectForKey:@"status"];
    NSNumber* maxSol = [dictionary objectForKey:@"max_sol"];
    NSString *maxDate = [dictionary objectForKey:@"max_date"];
    NSNumber* numberOfPhotos = [dictionary objectForKey:@"total_photos"];
    
    NSArray *photosArray = [dictionary objectForKey:@"photos"];
    
    NSMutableArray *sols = [[NSMutableArray alloc] init];
    
    for (NSDictionary *photoDictionary in photosArray) {
        NSNumber *sol = [photoDictionary valueForKey:@"sol"];
        [sols addObject:sol];
    }
    return [self initWithID:0
                       name:name
                 launchDate:launchDate
                landingDate:landingDate
                     status:status
                     maxSol:maxSol.intValue
                    maxDate:maxDate
             numberOfPhotos:numberOfPhotos.intValue
                       sols:sols];
}

@end
