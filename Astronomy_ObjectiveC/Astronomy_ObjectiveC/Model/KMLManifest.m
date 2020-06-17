//
//  KMLManifest.m
//  Astronomy_ObjectiveC
//
//  Created by Mark Poggi on 6/15/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

#import "KMLManifest.h"
#import "KMLSol.h"

@implementation KMLManifest

NSString *privateRoverName;
NSArray *privateSolIDs;
NSMutableArray *privateSols;

- (NSArray *)sols {
    return privateSols;
}

- (NSString *)roverName {
    return privateRoverName;
}

- (NSArray *)solIDs {
    return privateSolIDs;
}

- (instancetype)initWithRoverName: (NSString *)roverName solIDs:(NSArray *)sols {
    self = [super init];
    if (self) {
        privateRoverName = roverName;
        privateSolIDs = sols;
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

            self = [self initWithRoverName:roverName solIDs:solOutputArray];
            return self;
        }


    }
    return nil;
}

-(void)addSol:(KMLSol *)sol
{
    if(!privateSols) {
        privateSols = [[NSMutableArray alloc] init];
    }
    [privateSols addObject:sol];
}

@end
