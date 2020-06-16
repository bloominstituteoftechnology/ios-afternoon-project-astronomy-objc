//
//  Rover.m
//  Obj-C-Astronomy
//
//  Created by Patrick Millet on 6/16/20.
//  Copyright © 2020 PatrickMillet79. All rights reserved.
//

#import "Rover.h"

@implementation Rover
- (instancetype)initWithIdentifier:(int)identifier
                              name:(NSString *)name
                       landingDate:(NSString *)landingDate
                        launchDate:(NSString *)launchDate
                            status:(NSString *)status
                            maxSol:(int)maxSol
                           maxDate:(NSString *)maxDate
                       totalPhotos:(int)totalPhotos
                            sols:(NSArray *)sols
{
    if (self = [super init]) {
         _identifier = identifier;
         _name = name;
         _landingDate = landingDate;
         _launchDate = launchDate;
         _status = status;
         _maxSol = maxSol;
         _maxDate = maxDate;
         _totalPhotos = totalPhotos;
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
    NSNumber* totalPhotos = [dictionary objectForKey:@"total_photos"];

    NSArray *photosArray = [dictionary objectForKey:@"photos"];

    NSMutableArray *sols = [[NSMutableArray alloc] init];

    for (NSDictionary *photoDictionary in photosArray) {
        NSNumber *sol = [photoDictionary valueForKey:@"sol"];
        [sols addObject:sol];
    }

    return [self initWithIdentifier:0
                               name:name
                        landingDate:landingDate
                         launchDate:launchDate
                             status:status
                             maxSol:maxSol.intValue
                            maxDate:maxDate
                        totalPhotos:totalPhotos.intValue
                               sols: sols];
}

@end
