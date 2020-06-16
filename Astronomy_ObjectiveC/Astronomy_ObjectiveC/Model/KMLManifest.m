//
//  KMLManifest.m
//  Astronomy_ObjectiveC
//
//  Created by Mark Poggi on 6/15/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

#import "KMLManifest.h"

@implementation KMLManifest

- (instancetype)initWithRoverName: (NSString *)roverName sols:(NSArray *)sols {
    self = [super init];
    if (self) {
        _roverName = roverName;
        _sols = sols;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (dictionary) {
        if (dictionary[@"photo_manifest"] != [NSNull null]) {
            NSDictionary *roverDictionary = dictionary[@"photo_manifest"];
            NSString *roverName = roverDictionary[@"name"];
            NSArray *solArray = roverDictionary[@"photos"];

            NSMutableArray *solOutputArray = [[NSMutableArray alloc] init];
            for (int i=0; i < solArray.count; i++) {
                NSNumber *sol = solArray[i][@"sol"];
                [solOutputArray addObject: sol];
            }

            self = [self initWithRoverName:roverName sols:solOutputArray];
            return self;
        }


    }
    return nil;
}

@end
