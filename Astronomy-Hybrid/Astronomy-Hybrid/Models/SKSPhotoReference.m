//
//  SKSPhotoReference.m
//  Astronomy-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "SKSPhotoReference.h"

@implementation SKSPhotoReference


- (instancetype _Nullable)initWithID:(int)solId
                                 sol:(int)sol
                           earthDate:(nonnull NSDate *)earthDate
                            imageURL:(nonnull NSURL *)imageURL {
    self = [super init];
    if (self) {
        _solId = solId;
        _sol = sol;
        _earthDate = earthDate;
        _imageURL = imageURL;
    }
    return self;
}

- (instancetype _Nullable)initWithDictionary:(nonnull NSDictionary *)dictionary {

    NSNumber *solId = dictionary[@"id"];
    NSNumber *sol = dictionary[@"sol"];
    NSDate *earthDate = dictionary[@"earth_date"];
    NSURL *imageURL = [NSURL URLWithString:dictionary[@"img_src"]];
    NSLog(@"URL for image: %@", imageURL);

    return [self initWithID:[solId intValue] sol:[sol intValue] earthDate:earthDate imageURL:imageURL];
}

@end
